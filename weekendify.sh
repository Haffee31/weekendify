#!/usr/bin/env bash

# ============================================================
# 🌴  weekendify — It's the weekend. Go touch grass.
# ============================================================
# Kills the frontend dev server, tears down Docker/Sail,
# and shuts off Colima so your laptop can breathe too.
#
# Usage:
#   weekendify              — runs only on weekends
#   weekendify LEAVEMEALONE — bypass weekday guard (GTA:VC cheat)
# ------------------------------------------------------------
# Author  : Hafeez Mohamad
# LinkedIn: https://www.linkedin.com/in/hafeez-mohamad/
# ============================================================

set -euo pipefail

# ── Resolve real script directory (safe through symlinks) ────
_src="${BASH_SOURCE[0]}"
while [ -h "$_src" ]; do
  _dir="$(cd -P "$(dirname "$_src")" && pwd)"
  _src="$(readlink "$_src")"
  [[ "$_src" != /* ]] && _src="$_dir/$_src"
done
SCRIPT_DIR="$(cd -P "$(dirname "$_src")" && pwd)"
unset _src _dir

source "$SCRIPT_DIR/lib.sh"

# ── Cheat code detection ─────────────────────────────────────
# LEAVEMEALONE — GTA Vice City: clears your wanted level.
# Here it clears the weekday guard. Semantically perfect.
FORCE=false
CHEAT="${1:-}"
if [[ "$(echo "$CHEAT" | tr '[:lower:]' '[:upper:]')" == "$WEEKENDIFY_CHEAT" ]]; then
  FORCE=true
elif [[ -n "$CHEAT" ]]; then
  echo -e "${RED}  ❌  Unknown cheat code: '$CHEAT'${RESET}"
  echo -e "${DIM}     Try: $WEEKENDIFY_CHEAT${RESET}"
  echo ""
  exit 1
fi

# ── ASCII Banner ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}"
echo "  ██╗    ██╗███████╗███████╗██╗  ██╗███████╗███╗   ██╗██████╗ ██╗███████╗██╗   ██╗"
echo "  ██║    ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝████╗  ██║██╔══██╗██║██╔════╝╚██╗ ██╔╝"
echo "  ██║ █╗ ██║█████╗  █████╗  █████╔╝ █████╗  ██╔██╗ ██║██║  ██║██║█████╗   ╚████╔╝ "
echo "  ██║███╗██║██╔══╝  ██╔══╝  ██╔═██╗ ██╔══╝  ██║╚██╗██║██║  ██║██║██╔══╝    ╚██╔╝  "
echo "  ╚███╔███╔╝███████╗███████╗██║  ██╗███████╗██║ ╚████║██████╔╝██║██║        ██║   "
echo "   ╚══╝╚══╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝        ╚═╝   "
echo -e "${RESET}"
echo -e "${DIM}${CYAN}                  🌴  shutting it all down. you earned it.  🌴${RESET}"
echo ""

# ── Weekday guard ────────────────────────────────────────────
DOW=$(date +%u)  # 1=Mon ... 6=Sat, 7=Sun
DAY_NAME=$(date +%A)

ROASTS=(
  "It's $DAY_NAME. Respect yourself."
  "It's $DAY_NAME. The standup starts in 9 hours."
  "It's $DAY_NAME. Your Jira tickets are watching."
  "It's $DAY_NAME. Bold move, quitter."
  "It's $DAY_NAME. Your team will notice."
  "It's $DAY_NAME. The PRs won't review themselves."
  "It's $DAY_NAME. Capitalism is real and it's $DAY_NAME."
)

if [[ "$DOW" -lt 6 ]] && [[ "$FORCE" == false ]]; then
  ROAST="${ROASTS[$((RANDOM % ${#ROASTS[@]}))]}"
  echo -e "${BOLD}${RED}╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${RED}║  🚨  WEEKDAY DETECTED. ABORTING MISSION.                 ║${RESET}"
  echo -e "${BOLD}${RED}╚══════════════════════════════════════════════════════════╝${RESET}"
  echo ""
  echo -e "${YELLOW}  ${ROAST}${RESET}"
  echo ""
  echo -e "${DIM}  Enter the cheat code: ${RESET}${BOLD}${WEEKENDIFY_CMD} ${WEEKENDIFY_CHEAT}${RESET}"
  echo ""
  exit 0
fi

if [[ "$FORCE" == true ]] && [[ "$DOW" -lt 6 ]]; then
  echo -e "${YELLOW}  🎮  Cheat code accepted: $WEEKENDIFY_CHEAT — wanted level cleared. It's $DAY_NAME but the cops can't touch you.${RESET}"
  echo ""
fi

# ── 1. Kill the Next.js dev server ──────────────────────────
log "🔫  Hunting down the Next.js dev server..."
hacker_output \
  "locating node runtime in process table..." \
  "tracing webpack watcher file descriptors..." \
  "intercepting hot-reload websocket tunnel..." \
  "invalidating next.js module cache..." \
  "sending SIGTERM to renderer workers..." \
  "process tree collapsed. goodbye, localhost:3000."

NEXT_PIDS=$(pgrep -f "next dev" 2>/dev/null || true)
if [[ -n "$NEXT_PIDS" ]]; then
  kill $NEXT_PIDS 2>/dev/null
  success "Next.js dev server terminated  (PIDs: $NEXT_PIDS)"
else
  warn "No Next.js dev server found — already dead or never born."
fi

echo ""

# ── 2. Bring down Sail / Docker ──────────────────────────────
log "🐳  Telling Docker to pack its bags..."
hacker_output \
  "querying container orchestration layer..." \
  "draining active network bridges..." \
  "detaching named volumes from mount points..." \
  "stopping laravel.test, mysql, redis containers..." \
  "pruning internal overlay networks..." \
  "docker daemon standing down. whale has left the building."

if [[ -f "$BACKEND_DIR/vendor/bin/sail" ]]; then
  dim "Running: sail down"
  cd "$BACKEND_DIR"
  if ./vendor/bin/sail down 2>/dev/null; then
    success "Docker containers are down. Sweet silence."
  else
    warn "Docker isn't running — nothing to bring down."
  fi
else
  warn "Sail not found at $BACKEND_DIR/vendor/bin/sail — skipping."
fi

echo ""

# ── 3. Stop Colima ───────────────────────────────────────────
log "🖥️   Winding down Colima..."
hacker_output \
  "connecting to hypervisor control socket..." \
  "flushing lima vm write-back cache..." \
  "gracefully evicting in-memory page tables..." \
  "deallocating virtual cpu threads..." \
  "releasing rosetta 2 translation layer..." \
  "vm halted. your fans are already grateful."

if command -v colima &>/dev/null; then
  if colima status &>/dev/null; then
    dim "Running: colima stop"
    colima stop
    success "Colima stopped. Your fans will thank you."
  else
    warn "Colima isn't running — nothing to stop."
  fi
else
  warn "Colima not found in PATH — skipping."
fi

echo ""

# ── Done ─────────────────────────────────────────────────────
echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${GREEN}║  🍻  Stack annihilated. Close the lid. You're free.      ║${RESET}"
echo -e "${BOLD}${GREEN}╚══════════════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "${DIM}  Monday is $(( (8 - DOW) % 7 )) day(s) away. Don't think about it.${RESET}"
echo ""
