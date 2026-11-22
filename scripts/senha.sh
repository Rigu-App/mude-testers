#!/usr/bin/env bash
# rigu: digita a senha da conta de teste no campo em foco, sem mostrar o valor.
# Uso: bash scripts/senha.sh morador|sindico|didi-familia|didi-professora   (toque no campo antes)
set -uo pipefail
case "${1:-}" in
  morador) S="${SENHA_MORADOR:-}" ;;
  sindico) S="${SENHA_SINDICO:-}" ;;
  didi-familia) S="${SENHA_DIDI_FAMILIA:-}" ;;
  didi-professora) S="${SENHA_DIDI_PROFESSORA:-}" ;;
  *) echo "uso: bash scripts/senha.sh morador|sindico|didi-familia|didi-professora"; exit 1 ;;
esac
[ -n "$S" ] || { echo "valor não configurado"; exit 1; }
if [ -n "${UDID:-}" ]; then python3 scripts/ios/type.py "$S"; else python3 scripts/android/type.py "$S"; fi
