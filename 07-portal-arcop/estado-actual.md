# Portal ARCOP — Estado actual y documentación técnica

**Versión:** 2.x (prototipo en producción)  
**Fecha:** Febrero 2026  
**Stack:** React + Google Apps Script + Google Sheets

---

## Estado actual de implementación

| Derecho | Estado | Notas |
|---------|--------|-------|
| Acceso | ✅ Funcional en producción | Flujo completo |
| Rectificación | ✅ Funcional | Flujo completo |
| Cancelación | ✅ Funcional | Flujo completo |
| Oposición | ✅ Funcional | Flujo completo |
| Portabilidad | 🟡 Parcial | Falta confirmación descarga |

---

## Stack actual

| Componente | Tecnología | Notas |
|------------|-----------|-------|
| Frontend | React 18 | HashRouter, desplegado en Vercel |
| Backend | Google Apps Script | Serverless, sin infraestructura |
| Base de datos | Google Sheets | 2 hojas separadas (PII / No-PII) |
| Emails | Gmail API | Templates HTML compatibles multi-cliente |
| Notificaciones | Slack Webhooks | Configurables por tipo de derecho |
| Hosting | Vercel | Free tier actual |

---

## Arquitectura actual (prototipo)

```
Ciudadano/Titular
      │
      ▼ Portal público ARCOP
   React (Vercel)
      │
      ▼ Apps Script API
Google Apps Script ─── Google Sheets (datos)
      │                       ├── SOLICITUDES (sin PII)
      ▼                       └── TITULARES (con RUT/nombre)
  Gmail API
  (notificaciones)
```

> ⚠️ **Problema Art. 27:** Todos los servidores en EE.UU. = transferencia internacional bajo Ley 21.719. Resolver en Sprint 7–8 con migración Firebase Santiago.

---

## Estados de solicitud

| Estado | Descripción | Color UI |
|--------|-------------|----------|
| `PENDIENTE` | Recibida, sin validar | Amarillo |
| `VALIDADA` | Identidad confirmada | Azul |
| `EN_PROCESO` | DPO trabajando | Naranja |
| `RESUELTA` | Respuesta lista | Verde |
| `DESCARGA_CONFIRMADA` | Titular confirmó recepción | Verde oscuro |
| `CERRADA` | Proceso completo | Gris |

---

## Funcionalidades actuales

### Portal público (ciudadano)
- Formulario de solicitud para los 5 derechos ARCO
- Validación RUT (algoritmo módulo-11 chileno)
- Validación email con código temporal (30 min)
- Tracking público de solicitud por número

### Panel DPO
- Dashboard con métricas en tiempo real (Chart.js)
- Gestión de solicitudes con filtros y ordenamiento
- Cambio de estado con confirmación
- Asignación de responsables
- Exportación CSV / TXT
- Reportes de cumplimiento SLA (15 días hábiles)
- Notificaciones Slack configurables

### Configuración
- Plazos configurables (respuesta: 15 días, validación: 5 días, alerta: 3 días)
- Flujos personalizables por tipo de derecho
- Adaptación a identidad de la organización

---

## Plazos según Ley 21.719

| Tipo de plazo | Días | Configurado en |
|---------------|------|----------------|
| Respuesta máxima | 15 días hábiles | `DIAS_RESPUESTA` |
| Validación identidad | 5 días hábiles | `DIAS_VALIDACION` |
| Alerta vencimiento | 3 días antes | `DIAS_ALERTA` |

---

## Próximos sprints (desde NOW)

### Sprint activo — Completar 5 derechos
- [x] Acceso
- [x] Rectificación
- [x] Cancelación
- [x] Oposición
- [ ] Portabilidad — confirmación descarga pendiente

### Sprint 7–8 — Migración Firebase Santiago
- [ ] Activar proyecto Firebase en región `southamerica-west1`
- [ ] Implementar `firebaseAdapter.js` (stub ya existe)
- [ ] Migrar datos de Sheets a Firestore
- [ ] Verificar Art. 27 resuelto (datos en Chile)

### Sprint 9–10 — Dashboard ejecutivo + Audit logs
- [ ] Logs inmutables de todas las acciones
- [ ] Panel para auditores (solo lectura)
- [ ] Panel ejecutivo (métricas directivo)
- [ ] Exportación evidencias para APDP

---

## Problemas técnicos conocidos

| Problema | Severidad | Sprint |
|----------|-----------|--------|
| Datos en servidores EE.UU. (Art. 27) | 🔴 Alta | 7–8 |
| RUT en texto plano | 🟠 Media | 7–8 |
| Sin audit logs inmutables | 🟠 Media | 9–10 |
| Sin DPA de Google documentado | 🟠 Media | Inmediato |
| Portabilidad sin confirmación descarga | 🟡 Baja | Sprint activo |

---

## Variables de entorno requeridas (`.env.example`)

```bash
# URL del Google Apps Script desplegado
REACT_APP_SCRIPT_URL=https://script.google.com/macros/s/XXXXXXX/exec

# ID del Spreadsheet de Google
REACT_APP_SPREADSHEET_ID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# Webhook Slack (opcional)
REACT_APP_SLACK_WEBHOOK=https://hooks.slack.com/services/XXX/XXX/XXX
```

> ⚠️ **Nunca subir el `.env` con valores reales al repositorio.** Solo el `.env.example`.

---

## Repositorio de código

- **Repo:** `aligndata-platform` (privado)
- **Branch producción:** `main`
- **Branch desarrollo:** `develop`
- **Deploy:** Vercel (automático desde `main`)

---

*Portal ARCOP · Documentación técnica v2.x · Uso interno*
