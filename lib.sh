#!/usr/bin/env bash

# ============================================================
# lib.sh — shared colours, functions, and constants
# Sourced by weekendify.sh and mondayify.sh. Not run directly.
# ------------------------------------------------------------
# Author  : Hafeez Mohamad
# LinkedIn: https://www.linkedin.com/in/hafeez-mohamad/
# ============================================================

# ── Load user config ─────────────────────────────────────────
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$LIB_DIR/config.sh"

# ── Colours ─────────────────────────────────────────────────
BOLD="\033[1m"
DIM="\033[2m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
MAGENTA="\033[0;35m"
RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

# ── Logging helpers ──────────────────────────────────────────
log()     { echo -e "${BOLD}${CYAN}  $*${RESET}"; }
success() { echo -e "${GREEN}  ✅  $*${RESET}"; }
warn()    { echo -e "${YELLOW}  ⚠️   $*${RESET}"; }
fail()    { echo -e "${RED}  ❌  $*${RESET}"; }
dim()     { echo -e "${DIM}     $*${RESET}"; }
hack()    { echo -e "${MAGENTA}  $*${RESET}"; }

# ── hacker_output <line> <line> ... ─────────────────────────
# Scrolls fake terminal lines with a short delay between each.
hacker_output() {
  local lines=("$@")
  for line in "${lines[@]}"; do
    echo -e "${DIM}${MAGENTA}  > ${line}${RESET}"
    sleep 0.08
  done
}
