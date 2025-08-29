#!/usr/bin/env bash
set -euo pipefail

CODEXCLI_PREFIX="${HOME}/.local"
CODEXCLI_SHARE_DIR="${CODEXCLI_PREFIX}/share/codexcli"
CODEXCLI_BIN_DIR="${CODEXCLI_PREFIX}/bin"

if [ -L "${CODEXCLI_BIN_DIR}/codexcli" ] || [ -f "${CODEXCLI_BIN_DIR}/codexcli" ]; then
  rm -f "${CODEXCLI_BIN_DIR}/codexcli" || true
fi
if [ -L "${CODEXCLI_BIN_DIR}/codexclimage" ] || [ -f "${CODEXCLI_BIN_DIR}/codexclimage" ]; then
  rm -f "${CODEXCLI_BIN_DIR}/codexclimage" || true
fi

if [ -d "${CODEXCLI_SHARE_DIR}" ]; then
  rm -rf "${CODEXCLI_SHARE_DIR}" || true
fi

printf "codexcli uninstalled. Symlinks removed from %s.\n" "${CODEXCLI_BIN_DIR}"
printf "Project directory removed from %s.\n" "${CODEXCLI_SHARE_DIR}"
