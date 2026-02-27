# Diseño del Servicio — D360° Privacy Readiness Assessment

**Versión:** 1.0  
**Autor:** Patricio Oliva  
**Fecha:** 14 Febrero 2026  
**Estado:** 🟡 En revisión

---

## Introducción

El 1 de diciembre de 2026 comienza a regir la Ley 21.719 de Protección de Datos Personales. Las empresas deben prepararse implementando procesos, tecnología y capacitando personas para cumplir lo que la ley exigirá.

En PrivaData evaluamos: inventario de datos personales, nivel de sensibilidad, flujos de información, brechas (gap analysis), riesgos y nivel de madurez mínimo requerido.

---

## Líneas de desarrollo del servicio

### 1. Diagnóstico de cumplimiento de la privacidad (DCP)

**Temas principales:**
- Inventario de datos personales
- Identificación de datos sensibles
- Mapeo de flujos de información
- Evaluación de brechas (gap analysis)
- Evaluación de riesgos
- Nivel de madurez
- Informe ejecutivo con plan de acción

**Modalidades de venta:**
- 💰 Servicio cerrado
- 📊 Informe ejecutivo para directorio
- 📁 Documento técnico + matriz de riesgos

### 2. Plan de Adecuación

Luego del diagnóstico:
- Políticas de privacidad (legal/cumplimiento)
- Contratos con encargados de tratamiento (legal)
- Diseño de controles técnicos (TI)
- Diseño de procesos internos (legal/ops)
- Gobierno de datos (TI + legal)
- Capacitación (técnica y legal)
- Diseño de arquitectura segura (privacy by design)

### 3. Implementación Tecnológica

- Clasificación de datos: anonimación, silos, replicación
- Encriptación (TI)
- Control de acceso (roles y perfiles en aplicaciones)
- Auditoría (legal, relación con APDP)
- Logging (TI)
- Backups (TI)
- Retención (TI)
- Cloud governance (si aplica)
- Gestión documental
- **Automatización ARCO → AlignData Protect™** (SaaS o instalación on-premise)

---

## Producto Vendible: D360°

**Nombre completo:** Diagnóstico 360° de la Privacidad de Datos (D360°)

### Objetivo

Diagnosticar el nivel de cumplimiento de la empresa frente a la Ley 21.719 y entregar un **Plan de Adecuación Priorizado**, con enfoque legal, tecnológico y operativo.

---

### Fase 1 — Levantamiento (Discovery)

**Duración:** 1–2 semanas

**Entrevistas con:**
- Gerencia General (y directorio si corresponde)
- TI
- RRHH
- Comercial
- Operaciones

**Revisión documental:**
- Políticas actuales
- Contratos con proveedores
- Sistemas en uso

**Identificación de (foco TI):**
- Bases de datos
- Aplicaciones
- Flujos de información
- Proveedores cloud (verificación de contratos)

**Entregable interno:** Inventario preliminar de tratamientos de datos

---

### Fase 2 — Mapeo y Análisis de Brechas

**Duración:** 1 semana

| Dimensión | Pregunta clave |
|-----------|----------------|
| Gobierno de Datos | ¿Existe responsable formal? |
| Inventario de datos | ¿Está actualizado? |
| Datos sensibles | ¿Están identificados? |
| Seguridad técnica | ¿Hay cifrado, control de acceso, logs? |
| Procesos ARCO | ¿Existen flujos definidos? |
| Contratos | ¿Cláusulas adecuadas? |
| Retención | ¿Hay política formal? |
| Gestión de incidentes | ¿Existe protocolo? |

**Niveles de madurez asignados:**
- 0 = Inexistente
- 1 = Básico
- 2 = Intermedio
- 3 = Avanzado
- 4 = Cumplimiento estructurado

---

### Fase 3 — Informe Ejecutivo + Plan de Adecuación

**Entregable 1: Informe Ejecutivo para Directorio**
- Resumen de cumplimiento actual
- Riesgos críticos
- Exposición potencial a multas
- Recomendaciones estratégicas

**Entregable 2: Informe Técnico de Brechas**
- Matriz de cumplimiento artículo por artículo
- Riesgo clasificado: Bajo / Medio / Alto / Crítico
- Impacto reputacional
- Impacto financiero

**Entregable 3: Roadmap de Implementación**
- Acciones a 3 meses (quick wins)
- Acciones a 6 meses
- Acciones a 12 meses

---

### Componente: Dashboard Ejecutivo Interactivo

**Herramienta:** Power BI (Fase 1) → Dashboard propio SaaS (Fase 2+)

**El dashboard incluye:**
- % global de cumplimiento
- Nivel por dimensión (organizacional / TI / contractual)
- Mapa de calor de riesgos
- Nivel de exposición a sanciones
- Prioridades del roadmap
- Simulación de multa por escenario
- Comparativo sectorial (cuando haya base acumulada)

---

### Componente: Capacitación Incluida

**Sesión Ejecutiva (2 horas)**
- Dirigida a: Gerencia, Directorio, Alta administración
- Contenido: Impacto estratégico, responsabilidad personal, riesgo reputacional, exposición financiera, plan de acción

**Sesión Operativa (3–4 horas)**
- Dirigida a: TI, RRHH, Comercial, Operaciones
- Contenido: Principios de tratamiento, datos sensibles, procedimiento ARCO, gestión de incidentes, buenas prácticas

---

### Certificado de Evaluación

**Nombre:** "Empresa Evaluada en Cumplimiento Ley 21.719 – Nivel X"

Incluye:
- Nivel de madurez obtenido (0–4)
- Fecha de evaluación
- Vigencia sugerida: 12 meses
- Firma digital

> ⚠️ **Importante:** Esta es una certificación privada de evaluación independiente, NO certificación oficial del Estado. Posicionamiento correcto: "Evaluación independiente con metodología alineada a la Ley 21.719 y estándares internacionales."

---

## Modelo de Pricing

| Segmento | Precio sugerido |
|----------|----------------|
| 20–50 trabajadores | USD 2.000 – 3.000 |
| 50–150 trabajadores | USD 4.000 – 6.000 |
| Sector salud / aseguradoras | USD 6.000 – 10.000 |

> El valor aumenta si manejan datos sensibles masivos.

**Conversión a UF (referencia):**
- PYME: UF 40–60
- Mediana: UF 80–120
- Corporativo: UF 150+

---

## Diferenciador Clave

No solo entregamos un PDF. Entregamos:

- ✅ Matriz editable de evaluación de madurez
- ✅ Mapa de arquitectura actual de datos
- ✅ Diagrama de flujo de información
- ✅ Nivel de riesgo por sistema
- ✅ Estimación de inversión necesaria (con equipo TI del cliente)
- ✅ Dashboard ejecutivo interactivo
- ✅ Capacitación ejecutiva + operativa
- ✅ Certificado de evaluación (privado)

**Mensaje comercial clave:**
> "No espere una fiscalización para descubrir que no cumple."

---

## Elemento Estratégico

El D360° debe generar naturalmente:

1. **Proyecto de implementación** (Plan de Adecuación)
2. **Suscripción AlignData Protect™** (ARCO SaaS)
3. **DPO externo** (servicio mensual recurrente)
4. **Monitoreo anual** (auditoría recurrente)

> El diagnóstico es la puerta de entrada. El objetivo es la relación de largo plazo.

---

## Escalamiento

### Primer cliente piloto
- Precio preferencial (descuento 30–50%)
- A cambio de: caso de éxito documentado + testimonio + referencia
- Sector objetivo: salud, retail, educación, fintech, RRHH, municipios

### Canales de escalamiento
- Paquete estandarizado (plantillas, checklists, matrices)
- Marketing LinkedIn (contenido semanal sobre Ley 21.719)
- Webinars sobre Ley 21.719 (generación de leads)
- Convenios con gremios sectoriales

---

## Posicionamiento ante certificación estatal

### Situación actual (Febrero 2026)

La Ley 21.719 crea la Agencia de Protección de Datos Personales (APDP) pero los mecanismos formales de certificación se definirán por reglamento posterior.

| Situación | Estado |
|-----------|--------|
| Registro oficial de certificadores | ❌ No existe aún |
| Esquema ISO obligatorio | ❌ No existe aún |
| Licencia estatal para asesorar | ❌ No requerida |

### Estrategia de posicionamiento

**Certificaciones individuales (socios):**
- CIPP/E (IAPP) — referente directo Ley 21.719
- CIPM (IAPP) — gestión de programas privacidad
- ISO 27701 Lead Implementer (año 2)

**Certificación empresa:**
- ISO 27001 (año 2–3) — respaldo ante auditorías y licitaciones

**Modelo de certificación privada:**
- Ofrecemos: "Evaluación independiente con metodología alineada a Ley 21.719 e ISO 27701"
- Cuando salga el reglamento: nos adaptamos

---

*PrivaData SPA · Diseño de Servicios D360° · Uso interno y confidencial*
