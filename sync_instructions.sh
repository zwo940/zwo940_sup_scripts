#!/usr/bin/env bash

# SPDX-License-Identifier: Apache-2.0
# Copyright 2025 Marcus-Erich Seidler (zwo940.de)

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="${ROOT}/zwo940_sup_instructions/copilot-instructions.md"

sync_one() {
  local repo="$1"
  local dest="${ROOT}/${repo}/.github/copilot-instructions.md"
  mkdir -p "$(dirname "${dest}")"
  cp -f "${SRC}" "${dest}"
  echo "Synced -> ${dest}"
}

sync_one "zwo940_pkg_core"
sync_one "zwo940_pkg_ui"
sync_one "zwo940_app_vorrat"

echo "✅ Copilot-Instructions synchronisiert."

