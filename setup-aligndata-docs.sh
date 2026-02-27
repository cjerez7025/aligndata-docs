#!/bin/bash

# ============================================================
# setup-aligndata-docs.sh
# Script de inicialización del repositorio aligndata-docs
# Ejecutar UNA SOLA VEZ después de clonar la estructura
# ============================================================

echo "🚀 Iniciando repositorio aligndata-docs..."

# 1. Inicializar git
git init
git branch -M main

# 2. Configurar usuario (ajustar con datos reales)
# git config user.name "Carlos"
# git config user.email "carlos@privadata.cl"

# 3. Crear .gitignore
cat > .gitignore << 'EOF'
# Sistema operativo
.DS_Store
Thumbs.db
*.tmp

# Archivos con información sensible
*.env
secrets/
credentials/
*-passwords.*
*-credentials.*

# Datos de clientes (nunca en Git)
clientes/
datos-reales/
*-cliente-real.*

# Archivos temporales
*.swp
*.bak
~$*
EOF

echo "✅ .gitignore creado"

# 4. Primer commit
git add .
git commit -m "feat: estructura inicial aligndata-docs v1.0.0

Incluye:
- Plan de negocio AlignData (modelo financiero 3 años)
- Diseño de servicio D360° Privacy Readiness Assessment
- Especificación técnica AlignData Protect™
- Roadmap estratégico 2026
- Marco compliance Ley 21.719 + Art. 27
- Plan certificaciones CIPP/E, CIPM, ISO 27701
- Fondos CORFO / Start-Up Chile Ignite
- Documentación Portal ARCOP estado actual
- Brochure comercial (texto base para PDF)"

echo "✅ Primer commit realizado"

# 5. Crear tag de versión
git tag -a v1.0.0 -m "Versión inicial — Reunión socios Febrero 2026"
echo "✅ Tag v1.0.0 creado"

# 6. Instrucciones para conectar con GitHub
echo ""
echo "============================================="
echo "📋 PRÓXIMOS PASOS:"
echo "============================================="
echo ""
echo "1. Crear repo PRIVADO en github.com:"
echo "   Nombre: aligndata-docs"
echo "   Visibilidad: Private"
echo ""
echo "2. Conectar con GitHub:"
echo "   git remote add origin https://github.com/TU_USUARIO/aligndata-docs.git"
echo "   git push -u origin main"
echo "   git push origin --tags"
echo ""
echo "3. Invitar a Patricio como colaborador:"
echo "   GitHub → Settings → Collaborators → Add people"
echo ""
echo "✅ ¡Listo! Repositorio inicializado correctamente."
