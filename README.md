# 📁 aligndata-docs

> Repositorio de gestión documental estratégica — PrivaData SPA / AlignData

**Versión:** 1.0.0  
**Fecha inicio:** Febrero 2026  
**Estado:** 🟢 Activo

---

## 🧭 ¿Qué es este repositorio?

Gestión documental versionada de todo lo que construimos en **PrivaData SPA** y su producto estrella **AlignData Protect™**, incluyendo:

- Estrategia y plan de negocio
- Diseño de servicios (D360° / AlignData Advisory)
- Especificaciones técnicas del producto (Portal ARCOP / AlignData Protect™)
- Documentos legales y de compliance (Ley 21.719)
- Material de marketing y brochures
- Plan de certificaciones y fondos

---

## 🗂️ Estructura del repositorio

```
aligndata-docs/
│
├── 01-estrategia/          ← Plan de negocio, modelo financiero, roadmap
├── 02-servicios/           ← D360°, pricing, contratos
├── 03-producto/            ← Specs técnicas AlignData Protect™ / Portal ARCOP
├── 04-legal-compliance/    ← Ley 21.719, Art. 27, modelo prevención APDP
├── 05-marketing/           ← Brochure, pitch, LinkedIn
├── 06-certificaciones/     ← CIPP/E, ISO 27701, fondos CORFO / Start-Up Chile
├── 07-portal-arcop/        ← Documentación técnica del prototipo actual
└── assets/                 ← Archivos binarios (PPTX, PDF, imágenes)
```

---

## 👥 Equipo

| Rol | Responsable | Área principal |
|-----|-------------|----------------|
| Estrategia / PM / TI | Carlos | Producto, arquitectura, desarrollo |
| Consultoría / Negocio | Patricio | Servicios, branding, comercial |

---

## 📋 Convención de commits

```
docs(área): descripción del cambio
feat(área): nueva sección o documento
fix(área): corrección de contenido
refactor(área): reorganización sin cambio de contenido
```

**Ejemplos:**
```bash
git commit -m "docs(estrategia): actualiza modelo financiero Q2 2026"
git commit -m "feat(producto): agrega especificación módulo DPIA"
git commit -m "docs(servicios): ajusta pricing sector salud"
```

---

## 🔀 Ramas

| Rama | Propósito |
|------|-----------|
| `main` | Versión estable, documentos aprobados por ambos socios |
| `develop` | Trabajo en progreso, borradores |
| `feature/nombre` | Documentos nuevos en elaboración |

---

## ⚠️ Reglas del repositorio

- **Nunca** subir archivos `.env`, credenciales o datos de clientes reales
- Los Google Docs se exportan como `.md` antes de hacer commit
- Cada versión importante se etiqueta con `git tag` (ej: `v1.0-reunion-feb2026`)
- El historial de cambios fino vive en Google Docs; Git captura los hitos

---

## 🔗 Repositorios relacionados

| Repositorio | Descripción |
|-------------|-------------|
| `aligndata-platform` | Código fuente Portal ARCOP / AlignData Protect™ |
| `aligndata-docs` | Este repositorio — documentación estratégica |

---

## 📅 Historial de versiones principales

| Versión | Fecha | Descripción |
|---------|-------|-------------|
| v1.0.0 | Feb 2026 | Estructura inicial — Plan de negocio + Diseño D360° + Roadmap 2026 |

---

*PrivaData SPA · AlignData · Uso interno y confidencial*
