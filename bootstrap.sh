#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Workspace: ${ROOT_DIR}"
echo

# Prüfen ob flutter vorhanden ist
if ! command -v flutter >/dev/null 2>&1; then
  echo "FEHLER: flutter ist nicht im PATH. Bitte Flutter installieren/konfigurieren."
  exit 1
fi

# (Optional) Flutter version anzeigen
flutter --version | head -n 1 || true
echo

run_pub_get() {
  local dir="$1"
  if [[ -f "${dir}/pubspec.yaml" ]]; then
    echo "==> flutter pub get: ${dir}"
    (cd "${dir}" && flutter pub get)
    echo
  else
    echo "==> Übersprungen (kein pubspec.yaml): ${dir}"
    echo
  fi
}

# Reihenfolge: erst core, dann ui, dann app
run_pub_get "${ROOT_DIR}/zwo940_pkg_core"
run_pub_get "${ROOT_DIR}/zwo940_pkg_ui"
run_pub_get "${ROOT_DIR}/zwo940_app_vorrat"

echo "✅ Bootstrap fertig."

