#!/usr/bin/env bash

# ============================================================
# install.sh — install weekendify + mondayify as global commands
# ============================================================
# Run once from anywhere:
#   ./scripts/install.sh
#
# After install:
#   weekendify
#   weekendify LEAVEMEALONE
#   mondayify
#   mondayify ASPIRINE
# ------------------------------------------------------------
# Author  : Hafeez Mohamad
# LinkedIn: https://www.linkedin.com/in/hafeez-mohamad/
# ============================================================

set -euo pipefail

BOLD="\033[1m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
DIM="\033[2m"
RESET="\033[0m"

log()     { echo -e "${BOLD}${CYAN}  $*${RESET}"; }
success() { echo -e "${GREEN}  ✅  $*${RESET}"; }
warn()    { echo -e "${YELLOW}  ⚠️   $*${RESET}"; }
fail()    { echo -e "${RED}  ❌  $*${RESET}"; exit 1; }

# ── Resolve scripts directory and load config ────────────────
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/config.sh"

echo ""
echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${CYAN}║  🛠️   weekendify / mondayify — installer                  ║${RESET}"
echo -e "${BOLD}${CYAN}╚══════════════════════════════════════════════════════════╝${RESET}"
echo ""

# ── Make all scripts executable ──────────────────────────────
log "Setting execute permissions..."
chmod +x "$SCRIPTS_DIR/lib.sh"
chmod +x "$SCRIPTS_DIR/config.sh"
chmod +x "$SCRIPTS_DIR/weekendify.sh"
chmod +x "$SCRIPTS_DIR/mondayify.sh"
success "Permissions set."
echo ""

# ── Pick install directory ────────────────────────────────────
# Prefer /usr/local/bin (standard on macOS). Fall back to ~/.local/bin.
if [[ -d "/usr/local/bin" ]] && [[ -w "/usr/local/bin" ]]; then
  INSTALL_DIR="/usr/local/bin"
else
  INSTALL_DIR="$HOME/.local/bin"
  mkdir -p "$INSTALL_DIR"
  warn "  /usr/local/bin not writable. Installing to $INSTALL_DIR instead."
  echo ""
fi

log "Installing to $INSTALL_DIR..."

# ── Create symlinks ───────────────────────────────────────────
ln -sf "$SCRIPTS_DIR/weekendify.sh" "$INSTALL_DIR/$WEEKENDIFY_CMD"
success "  weekendify.sh  →  $INSTALL_DIR/$WEEKENDIFY_CMD"

ln -sf "$SCRIPTS_DIR/mondayify.sh"  "$INSTALL_DIR/$MONDAYIFY_CMD"
success "  mondayify.sh   →  $INSTALL_DIR/$MONDAYIFY_CMD"

echo ""

# ── PATH check for ~/.local/bin ───────────────────────────────
if [[ "$INSTALL_DIR" == "$HOME/.local/bin" ]]; then
  if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    warn "  $HOME/.local/bin is not in your PATH."
    echo ""
    echo -e "${DIM}  Add this to your ~/.zshrc or ~/.bashrc:${RESET}"
    echo -e "${BOLD}  export PATH=\"\$HOME/.local/bin:\$PATH\"${RESET}"
    echo ""
    echo -e "${DIM}  Then reload your shell:${RESET}"
    echo -e "${BOLD}  source ~/.zshrc${RESET}"
    echo ""
  fi
fi

# ── Done ─────────────────────────────────────────────────────
echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${GREEN}║  🎉  All done. Commands are ready globally.              ║${RESET}"
echo -e "${BOLD}${GREEN}╚══════════════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "  ${BOLD}${WEEKENDIFY_CMD}${RESET}               — shut it all down (weekends only)"
echo -e "  ${BOLD}${WEEKENDIFY_CMD} ${WEEKENDIFY_CHEAT}${RESET}  — force shutdown any day"
echo ""
echo -e "  ${BOLD}${MONDAYIFY_CMD}${RESET}                — boot it all up (weekdays)"
echo -e "  ${BOLD}${MONDAYIFY_CMD} ${MONDAYIFY_CHEAT}${RESET}       — force boot on weekends"
echo ""
echo -e "${DIM}  To uninstall: rm $INSTALL_DIR/$WEEKENDIFY_CMD $INSTALL_DIR/$MONDAYIFY_CMD${RESET}"
echo ""
