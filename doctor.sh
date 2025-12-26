#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Doctor für Workspace: ${ROOT_DIR}"
echo

echo "==> flutter"
command -v flutter >/dev/null 2>&1 && flutter --version | head -n 1 || echo "FEHLER: flutter fehlt"
echo

echo "==> git"
command -v git >/dev/null 2>&1 && git --version || echo "FEHLER: git fehlt"
echo

check_repo() {
  local dir="$1"
  echo "==> Repo: ${dir}"
  if [[ -d "${dir}/.git" ]]; then
    (cd "${dir}" && echo "Branch: $(git branch --show-current)" && git remote -v | sed 's/^/  /')
  else
    echo "  WARNUNG: kein .git gefunden"
  fi
  echo
}

check_repo "${ROOT_DIR}/zwo940_pkg_core"
check_repo "${ROOT_DIR}/zwo940_pkg_ui"
check_repo "${ROOT_DIR}/zwo940_app_vorrat"

echo "✅ Doctor fertig."

