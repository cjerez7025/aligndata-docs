# Especificación Técnica — AlignData Protect™

**Versión:** 1.0  
**Fecha:** Febrero 2026  
**Estado:** 🔵 Arquitectura definida — desarrollo en curso

---

## Visión del producto

**AlignData Protect™** es una plataforma SaaS multi-tenant de Gestión de Privacidad y Cumplimiento, alineada a Ley 21.719 e ISO/IEC 27701, diseñada para PYMES chilenas con proyección a medianas empresas y expansión LATAM.

---

## Stack tecnológico

| Capa | Tecnología | Razón |
|------|-----------|-------|
| Frontend | React / Next.js en Vercel | Time-to-market, SSR, CI/CD |
| Backend API | Azure Functions (Node/TypeScript) | Serverless escalable, portable |
| Base de datos | Azure PostgreSQL Flexible Server | Multi-tenant robusto, SQL compliance |
| Storage evidencias | Azure Blob Storage | Con hash SHA-256 por archivo |
| Secretos | Azure Key Vault | Seguridad enterprise |
| Colas | Azure Service Bus | Jobs async, exportaciones, notificaciones |
| Observabilidad | App Insights + Log Analytics | Traces, métricas, cold starts |
| IaC | Terraform | Portable a AWS sin reescribir |

> **Decisión estratégica:** Core en Azure (región Chile Central cuando disponible). Arquitectura portable a AWS por equivalencias directas.

### Equivalencias Azure → AWS para migración futura

| Azure | AWS |
|-------|-----|
| Azure Functions | AWS Lambda |
| Azure PostgreSQL | RDS PostgreSQL / Aurora |
| Blob Storage | S3 |
| Key Vault | KMS + Secrets Manager |
| Service Bus | SQS / SNS / EventBridge |
| App Insights | CloudWatch / X-Ray |

---

## Arquitectura de componentes

```
Internet / Usuarios
├── Titulares (Portal ARCO público)
└── Equipo Cliente (Backoffice DPO)
         │
         ▼ https://cliente.aligndata.cl
┌─────────────────────────────────┐
│           VERCEL                │
│  React/Next — Dashboard + ARCO  │
│  Middleware: /api/* → Azure Fn  │
└─────────────────────────────────┘
         │
         ▼ (subdominio → tenant_key)
┌─────────────────────────────────┐
│     AZURE FUNCTIONS (Node/TS)   │
│  Auth, ARCO, Evidence, Dashboard│
│  - Resuelve tenant_key          │
│  - SET search_path              │
│  - RBAC / autorización          │
│  - Registra audit_event         │
└─────────────────────────────────┘
    │              │             │
    ▼              ▼             ▼
PostgreSQL    Blob Storage  Service Bus
(schemas)     (evidencias)  (jobs async)
    │
    ▼
Key Vault + App Insights
```

---

## Modelo multi-tenant: Schema por tenant

### Estructura

- **Schema `public`:** catálogo global — tenants, users, user_tenants, audit global
- **Schema `t_<tenantKey>`:** datos operacionales del cliente

### Convención de nombres

- `tenant_key` = subdominio (ej: `clinicax` de `clinicax.aligndata.cl`)
- `schema_name` = `t_` + tenant_key → `t_clinicax`
- Validación: solo `[a-z0-9_]+`, largo 3–30 chars

### Beneficios

- Aislamiento demostrable ante due diligence
- Backup/restore por tenant controlable
- Migración individual de tenant a otro servidor/DB

---

## Modelo de datos

### Schema `public` (global)

```sql
-- Tenants
CREATE TABLE public.tenants (
  tenant_id   uuid PRIMARY KEY,
  tenant_key  text NOT NULL UNIQUE,
  name        text NOT NULL,
  industry    text,
  plan        text NOT NULL DEFAULT 'basic',
  status      text NOT NULL DEFAULT 'active',
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- Usuarios
CREATE TABLE public.users (
  user_id     uuid PRIMARY KEY,
  email       text NOT NULL UNIQUE,
  name        text,
  status      text NOT NULL DEFAULT 'active',
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- Relación usuario-tenant
CREATE TABLE public.user_tenants (
  user_id     uuid NOT NULL REFERENCES public.users(user_id),
  tenant_id   uuid NOT NULL REFERENCES public.tenants(tenant_id),
  role        text NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, tenant_id)
);
```

### Schema `t_<tenantKey>` — tablas core

```sql
-- Solicitudes ARCO
CREATE TABLE arco_request (
  request_id          uuid PRIMARY KEY,
  type                text NOT NULL,  -- access/rectification/cancellation/opposition/portability
  channel             text NOT NULL,  -- web/email/presencial
  subject_fullname    text NOT NULL,
  subject_id_type     text NOT NULL,  -- RUT/pasaporte/otro
  subject_id_value    text NOT NULL,  -- cifrar en Fase 2
  subject_contact_email text,
  subject_contact_phone text,
  received_at         timestamptz NOT NULL DEFAULT now(),
  due_at              timestamptz NOT NULL,
  status              text NOT NULL,
  assigned_to_user_id uuid NULL,
  notes               text,
  created_by_user_id  uuid NULL,
  updated_at          timestamptz NOT NULL DEFAULT now()
);

-- Actividades / historial
CREATE TABLE arco_activity (
  activity_id    uuid PRIMARY KEY,
  request_id     uuid NOT NULL REFERENCES arco_request(request_id),
  ts             timestamptz NOT NULL DEFAULT now(),
  actor_user_id  uuid NULL,
  action         text NOT NULL,
  details        jsonb NOT NULL DEFAULT '{}'
);

-- Evidencias (metadata — archivo en Blob)
CREATE TABLE evidence_object (
  evidence_id          uuid PRIMARY KEY,
  request_id           uuid NULL REFERENCES arco_request(request_id),
  blob_key             text NOT NULL,
  file_name            text NOT NULL,
  content_type         text NOT NULL,
  size_bytes           bigint NOT NULL,
  sha256_hash          text NULL,
  uploaded_at          timestamptz NOT NULL DEFAULT now(),
  uploaded_by_user_id  uuid NULL
);

-- Auditoría inmutable del tenant
CREATE TABLE audit_event (
  event_id     uuid PRIMARY KEY,
  ts           timestamptz NOT NULL DEFAULT now(),
  user_id      uuid NULL,
  action       text NOT NULL,
  entity_type  text NOT NULL,
  entity_id    uuid NULL,
  ip           text NULL,
  user_agent   text NULL,
  details      jsonb NOT NULL DEFAULT '{}'
);

-- Registro de tratamientos (Fase 2 — dejar esqueleto)
CREATE TABLE treatment_registry (
  treatment_id      uuid PRIMARY KEY,
  name              text NOT NULL,
  purpose           text,
  legal_basis       text,
  data_categories   jsonb NOT NULL DEFAULT '[]',
  sensitive         boolean NOT NULL DEFAULT false,
  retention_policy  text,
  processors        jsonb NOT NULL DEFAULT '[]',
  systems_involved  jsonb NOT NULL DEFAULT '[]',
  risk_level        text NOT NULL DEFAULT 'low',
  updated_at        timestamptz NOT NULL DEFAULT now()
);
```

---

## Máquina de estados ARCO

### Estados

| # | Estado | Descripción |
|---|--------|-------------|
| 1 | `RECEIVED` | Solicitud recibida |
| 2 | `VALIDATING_IDENTITY` | Verificando identidad del titular |
| 3 | `AWAITING_INFO` | Faltan antecedentes o documentos |
| 4 | `IN_PROGRESS` | Búsqueda/gestión interna |
| 5 | `LEGAL_REVIEW` | Revisión legal (salud/finanzas) |
| 6 | `READY_TO_RESPOND` | Trabajo terminado, listo para responder |
| 7 | `RESPONDED` | Respuesta emitida al titular |
| 8 | `CLOSED` | Cierre administrativo |
| 9 | `REJECTED` | Solicitud inválida o improcedente |
| 10 | `WITHDRAWN` | Titular desistió |

> `OVERDUE` no es un estado, es un **flag calculado**: `due_at < now()` y estado no es terminal.

### Transiciones permitidas

| Desde | Hacia | Condición |
|-------|-------|-----------|
| RECEIVED | VALIDATING_IDENTITY | Siempre |
| RECEIVED | AWAITING_INFO | Falta info mínima |
| RECEIVED | REJECTED | Improcedente evidente |
| VALIDATING_IDENTITY | IN_PROGRESS | Identidad validada |
| VALIDATING_IDENTITY | AWAITING_INFO | Necesita documento |
| VALIDATING_IDENTITY | REJECTED | Identidad no validable |
| AWAITING_INFO | IN_PROGRESS | Info recibida completa |
| AWAITING_INFO | WITHDRAWN | Titular desiste |
| IN_PROGRESS | LEGAL_REVIEW | Requiere revisión legal |
| IN_PROGRESS | READY_TO_RESPOND | Trabajo terminado |
| IN_PROGRESS | AWAITING_INFO | Se necesita más info |
| LEGAL_REVIEW | READY_TO_RESPOND | Aprobado |
| LEGAL_REVIEW | IN_PROGRESS | Observaciones |
| READY_TO_RESPOND | RESPONDED | Respuesta emitida |
| RESPONDED | CLOSED | Cierre administrativo |
| Cualquiera (excepto CLOSED) | WITHDRAWN | Desistimiento titular |
| Cualquiera (excepto CLOSED) | REJECTED | Causal legal formal |

---

## RBAC — Roles y permisos

### Roles

| Rol | Descripción |
|-----|-------------|
| `TENANT_ADMIN` | Acceso total, administra usuarios y config |
| `DPO` | Gestiona ARCO end-to-end, puede exportar |
| `LEGAL_REVIEWER` | Lectura + revisión legal, no administra |
| `ARCO_OPERATOR` | Crea/actualiza solicitudes, adjunta evidencias |
| `AUDITOR_VIEWER` | Solo lectura dashboard + auditoría |
| `READ_ONLY` | Solo lectura ARCO y dashboard |

### Matriz de permisos

| Permiso | ADMIN | DPO | LEGAL | OPERATOR | AUDITOR | VIEWER |
|---------|-------|-----|-------|----------|---------|--------|
| arco:create | ✅ | ✅ | ⛔ | ✅ | ⛔ | ⛔ |
| arco:read | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| arco:update | ✅ | ✅ | ✅* | ✅ | ⛔ | ⛔ |
| arco:close | ✅ | ✅ | ✅* | ⛔ | ⛔ | ⛔ |
| arco:reject | ✅ | ✅ | ✅* | ⛔ | ⛔ | ⛔ |
| arco:export | ✅ | ✅ | ⛔ | ⛔ | ⛔ | ⛔ |
| evidence:upload | ✅ | ✅ | ⛔ | ✅ | ⛔ | ⛔ |
| evidence:download | ✅ | ✅ | ✅* | ✅* | ✅* | ⛔ |
| audit:read | ✅ | ✅ | ✅ | ⛔ | ✅ | ⛔ |
| audit:export | ✅ | ✅ | ⛔ | ⛔ | ✅* | ⛔ |
| admin:users_manage | ✅ | ⛔ | ⛔ | ⛔ | ⛔ | ⛔ |

*= configurable por política del tenant (argumento Enterprise)

---

## Modelo de token JWT

```json
{
  "iss": "https://auth.aligndata.cl",
  "aud": "aligndata-protect",
  "sub": "uuid-user",
  "email": "usuario@cliente.cl",
  "tenant_key": "cliente",
  "tenant_id": "uuid-tenant",
  "role": "DPO",
  "permissions": ["arco:create", "arco:read", "arco:close", "evidence:upload", "audit:read"],
  "plan": "pro",
  "iat": 1735686000,
  "exp": 1735689600
}
```

**Reglas:**
- Firmar con RS256 (clave privada en Azure Key Vault)
- Expiración corta: 15–30 min
- Refresh token separado
- Revocación: invalidar `user.status` o `tenant.status`

---

## API Contract (resumen)

### Base URL: `https://cliente.aligndata.cl/api`

| Método | Endpoint | Permiso |
|--------|----------|---------|
| GET | /me | Autenticado |
| POST | /arco/requests | arco:create |
| GET | /arco/requests | arco:read |
| GET | /arco/requests/:id | arco:read |
| PATCH | /arco/requests/:id | arco:update |
| POST | /arco/requests/:id/status | arco:change_status |
| POST | /arco/requests/:id/close | arco:close |
| POST | /arco/requests/:id/reject | arco:reject |
| GET | /arco/requests/:id/export | arco:export |
| POST | /evidence/upload-url | evidence:upload |
| POST | /evidence/:id/confirm | evidence:upload |
| GET | /evidence/:id/download-url | evidence:download |
| GET | /dashboard/summary | reports:read |
| GET | /audit/events | audit:read |
| GET | /admin/users | admin:users_manage |
| POST | /admin/tenants | admin:users_manage |

---

## Planes SaaS

| Plan | Precio mensual | Incluye |
|------|---------------|---------|
| **Basic (PYME)** | USD 400–600 | ARCO + Dashboard + Registro tratamientos |
| **Pro** | USD 800–1.200 | + Gestión riesgos + Evaluación impacto + Reportes avanzados |
| **Enterprise** | USD 1.500–2.500 | + ISO 27701 alignment + Gestión terceros + API |

---

## Roadmap de producto

| Fase | Timeline | Módulos |
|------|----------|---------|
| MVP | Hoy → Q3 2026 | Portal ARCO + Workflow + Dashboard básico |
| Fase 2 | Q4 2026 → Q1 2027 | Registro tratamientos + Gestión riesgos + Matriz Ley 21.719 |
| Fase 3 | 2027 | DPIA + Gestión terceros + Indicadores ISO 27701 + Evidencia auditoría |

---

*AlignData Protect™ · Especificación técnica v1.0 · Confidencial*
