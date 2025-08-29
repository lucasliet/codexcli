#!/usr/bin/env bash
set -euo pipefail

CODEXCLI_REPO_URL="https://github.com/lucasliet/codexcli"
CODEXCLI_PREFIX="${HOME}/.local"
CODEXCLI_SHARE_DIR="${CODEXCLI_PREFIX}/share/codexcli"
CODEXCLI_BIN_DIR="${CODEXCLI_PREFIX}/bin"
CODEXCLI_TMP_DIR="$(mktemp -d 2>/dev/null || mktemp -d -t codexcli)"

mkdir -p "${CODEXCLI_BIN_DIR}"
mkdir -p "${CODEXCLI_PREFIX}/share"

if [ -d "${CODEXCLI_SHARE_DIR}" ] && [ -d "${CODEXCLI_SHARE_DIR}/.git" ] && command -v git >/dev/null 2>&1; then
  git -C "${CODEXCLI_SHARE_DIR}" fetch -q origin || true
  git -C "${CODEXCLI_SHARE_DIR}" checkout -q main || true
  git -C "${CODEXCLI_SHARE_DIR}" pull -q --ff-only || true
  git -C "${CODEXCLI_SHARE_DIR}" submodule update --init --recursive -q || true
else
  if [ -d "${CODEXCLI_SHARE_DIR}" ] && [ ! -d "${CODEXCLI_SHARE_DIR}/.git" ]; then
    mv "${CODEXCLI_SHARE_DIR}" "${CODEXCLI_SHARE_DIR}.bak.$(date +%s)" || true
  fi
  if command -v git >/dev/null 2>&1; then
    git clone --depth 1 "${CODEXCLI_REPO_URL}" "${CODEXCLI_SHARE_DIR}" -q || true
    git -C "${CODEXCLI_SHARE_DIR}" submodule update --init --recursive -q || true
  else
    CODEXCLI_ARCHIVE_URL="https://github.com/lucasliet/codexcli/archive/refs/heads/main.tar.gz"
    mkdir -p "${CODEXCLI_TMP_DIR}/dl"
    curl -fsSL "${CODEXCLI_ARCHIVE_URL}" | tar -xz -C "${CODEXCLI_TMP_DIR}/dl" || true
    if [ -d "${CODEXCLI_TMP_DIR}/dl/codexcli-main" ]; then
      rm -rf "${CODEXCLI_SHARE_DIR}" || true
      mv "${CODEXCLI_TMP_DIR}/dl/codexcli-main" "${CODEXCLI_SHARE_DIR}" || true
    fi
  fi
fi

chmod +x "${CODEXCLI_SHARE_DIR}/codexcli" 2>/dev/null || true
ln -sf "${CODEXCLI_SHARE_DIR}/codexcli" "${CODEXCLI_BIN_DIR}/codexcli"

if ! printf %s ":${PATH}:" | grep -q ":${CODEXCLI_BIN_DIR}:"; then
  CODEXCLI_SHELL_NAME="$(basename "${SHELL:-sh}")"
  CODEXCLI_TARGET_RC="${HOME}/.profile"
  if [ "${CODEXCLI_SHELL_NAME}" = "zsh" ]; then CODEXCLI_TARGET_RC="${HOME}/.zshrc"; fi
  if [ "${CODEXCLI_SHELL_NAME}" = "bash" ]; then CODEXCLI_TARGET_RC="${HOME}/.bashrc"; fi
  mkdir -p "$(dirname "${CODEXCLI_TARGET_RC}")"
  touch "${CODEXCLI_TARGET_RC}"
  if ! grep -qs "^export PATH=\"\$HOME/.local/bin:\$PATH\"" "${CODEXCLI_TARGET_RC}"; then
    printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "${CODEXCLI_TARGET_RC}"
  fi
fi

printf "codexcli installed to %s and linked in %s\n" "${CODEXCLI_SHARE_DIR}" "${CODEXCLI_BIN_DIR}"
printf "Open a new shell session or source your shell rc file to update PATH.\n"
