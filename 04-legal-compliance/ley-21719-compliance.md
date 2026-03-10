# Ley 21.719 — Marco de Compliance

**Versión:** 1.0  
**Fecha:** Febrero 2026  
**Estado:** 🔴 Crítico — Deadline 1 Dic 2026

---

## Resumen ejecutivo

La Ley 21.719 de Protección de Datos Personales de Chile entra en vigor el **1 de diciembre de 2026**. Establece el marco legal de cómo las empresas deben administrar y responsabilizarse por la información personal que almacenan de clientes, empleados y personas relacionadas.

**Multa máxima:** hasta 10.000 UTM (~$600M CLP) por infracciones graves.

---

## Derechos ARCO garantizados

| Derecho | Artículo | Plazo respuesta | Descripción |
|---------|----------|----------------|-------------|
| Acceso | Art. 5° | 15 días hábiles | El titular puede saber qué datos se tienen de él |
| Rectificación | Art. 6° | 15 días hábiles | Corregir datos inexactos o incompletos |
| Cancelación/Supresión | Art. 7° | 15 días hábiles | Eliminar datos que ya no corresponde tratar |
| Oposición | Art. 8° | 15 días hábiles | Oponerse al tratamiento por motivos legítimos |
| Portabilidad | Art. 9° | 15 días hábiles | Recibir sus datos en formato estructurado |

> **ARCOP** = Acceso, Rectificación, Cancelación, Oposición, Portabilidad

---

## Art. 27 — Transferencia Internacional de Datos

### ¿Qué dice?

La transferencia de datos personales a destinatarios en el extranjero es lícita solo si se cumple alguna de estas condiciones:

1. **País receptor con nivel adecuado de protección** (reconocido por la APDP)
2. **Garantías contractuales** (Cláusulas Contractuales Modelo — CCM)
3. **Consentimiento explícito** del titular

### ¿Por qué es crítico para AlignData Protect™?

El stack actual usa Google Apps Script + Google Sheets + Gmail API, todos en servidores de EE.UU. Eso constituye **transferencia internacional** bajo Art. 27.

### Problemas actuales del prototipo (Portal ARCOP v1)

| Problema | Riesgo |
|----------|--------|
| Sin Google DPA documentado | Transferencia sin garantía |
| Sin aviso al titular sobre transferencia | Infracción Art. 27 |
| Sin región configurable (datos en EE.UU.) | Transferencia internacional no declarada |
| RUT en texto plano | Dato personal sin cifrar |
| Sin audit logs inmutables | Sin evidencia ante fiscalización |

**Riesgo:** Infracción grave → multa hasta 10.000 UTM (~$600M CLP)

### Solución de arquitectura

La migración a **Firebase región southamerica-west1 (Santiago)** o **Azure Chile Central** resuelve Art. 27 porque los datos no salen de Chile → no hay transferencia internacional.

---

## Opciones de arquitectura por cumplimiento Art. 27

| Opción | Costo | Compliance | Prioridad |
|--------|-------|-----------|-----------|
| 2 Sheets separadas (PII vs no-PII) | $0 | Reduce riesgo, no resuelve | Inmediata (Sprint 0) |
| Firebase región Santiago | $0–15 USD/mes | Resuelve Art. 27 | Sprint 3–4 |
| Azure Chile Central (PostgreSQL) | $25–35 USD/mes | Resuelve Art. 27 + enterprise | Sprint 5+ |
| VPS PostgreSQL Santiago | $20–40 USD/mes | Resuelve Art. 27 | Alternativa |

---

## Modelo de Prevención de Infracciones

### ¿Qué es?

La Ley 21.719 permite a las organizaciones certificar ante la APDP que tienen implementado un **Modelo de Prevención de Infracciones** (similar al Modelo de Prevención de Delitos de la Ley 20.393).

### Beneficios de tener el modelo certificado

- Inscripción en el **Registro Nacional de Cumplimiento** (vigencia 3 años)
- Entre las circunstancias atenuantes de multas: "haber cumplido diligentemente deberes de dirección y supervisión", verificable con la certificación
- **Argumento comercial central de AlignData:** vendemos el camino hacia esta certificación

### Cómo lo monetizamos

El D360° + Plan de Adecuación + AlignData Protect™ juntos constituyen el camino hacia que el cliente obtenga la certificación de su Modelo de Prevención ante la APDP.

---

## Agencia de Protección de Datos Personales (APDP)

La Ley 21.719 crea la APDP con:
- Potestad fiscalizadora
- Poder sancionatorio (hasta 10.000 UTM)
- Posibilidad de certificar modelos de prevención
- Creación del Registro Nacional de Cumplimiento

> Los mecanismos específicos de certificación se definirán en reglamentos posteriores (aún no publicados a Feb 2026).

---

## Checklist de compliance para Portal ARCOP (priorizado)

### Inmediato (antes de Q2 2026)
- [ ] Documentar Google DPA vigente
- [ ] Separar datos PII en hoja separada (2-Sheets approach)
- [ ] Agregar aviso de transferencia internacional en formulario público
- [ ] Implementar logs básicos de acciones DPO

### Q2–Q3 2026
- [ ] Migrar a Firebase Santiago o Azure Chile Central
- [ ] Cifrar RUT y datos sensibles en reposo
- [ ] Implementar audit logs inmutables
- [ ] Dashboard de cumplimiento para auditores

### Q4 2026 (antes del 1 Dic)
- [ ] Postular certificación Modelo de Prevención ante APDP
- [ ] Documentación completa exportable para fiscalización
- [ ] SLA 99.9% documentado
- [ ] Plan de recuperación ante desastres (DR)

---

*AlignData · Análisis compliance Ley 21.719 · Uso interno y confidencial*
