#!/usr/bin/env bash

# ============================================================
# 💀  mondayify — Boot up. Clock in. Survive.
# ============================================================
# Starts Colima, fires up Docker/Sail, pulls latest staging,
# and launches the Next.js dev server. All at once.
#
# Usage:
#   mondayify          — runs on any weekday (Monday encouraged)
#   mondayify ASPIRINE — bypass weekend guard (GTA:VC cheat)
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
# ASPIRINE — GTA Vice City: full health restore.
# Because surviving Monday requires full HP.
FORCE=false
CHEAT="${1:-}"
if [[ "$(echo "$CHEAT" | tr '[:lower:]' '[:upper:]')" == "$MONDAYIFY_CHEAT" ]]; then
  FORCE=true
elif [[ -n "$CHEAT" ]]; then
  echo -e "${RED}  ❌  Unknown cheat code: '$CHEAT'${RESET}"
  echo -e "${DIM}     Try: $MONDAYIFY_CHEAT${RESET}"
  echo ""
  exit 1
fi

# ── ASCII Banner ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}${CYAN}"
echo "  ███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗██╗███████╗██╗   ██╗"
echo "  ████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝██║██╔════╝╚██╗ ██╔╝"
echo "  ██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ ██║█████╗   ╚████╔╝ "
echo "  ██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  ██║██╔══╝    ╚██╔╝  "
echo "  ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   ██║██║        ██║   "
echo "  ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝        ╚═╝   "
echo -e "${RESET}"
echo -e "${DIM}${CYAN}               💀  booting up. the jira board is waiting.  💀${RESET}"
echo ""

# ── Weekend guard ────────────────────────────────────────────
DOW=$(date +%u)  # 1=Mon ... 6=Sat, 7=Sun
DAY_NAME=$(date +%A)

if [[ "$DOW" -ge 6 ]] && [[ "$FORCE" == false ]]; then
  echo -e "${BOLD}${YELLOW}╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${YELLOW}║  🏖️   IT'S THE WEEKEND. WHAT ARE YOU DOING.              ║${RESET}"
  echo -e "${BOLD}${YELLOW}╚══════════════════════════════════════════════════════════╝${RESET}"
  echo ""
  echo -e "${CYAN}  It's $DAY_NAME. The stack will survive without you.${RESET}"
  echo -e "${CYAN}  Close the laptop. Touch grass. Drink something.${RESET}"
  echo ""
  echo -e "${DIM}  If you MUST: ${RESET}${BOLD}${MONDAYIFY_CMD} ${MONDAYIFY_CHEAT}${RESET}"
  echo ""
  exit 0
fi

if [[ "$FORCE" == true ]] && [[ "$DOW" -ge 6 ]]; then
  echo -e "${YELLOW}  🎮  Cheat code accepted: $MONDAYIFY_CHEAT — full health restored. Booting up on $DAY_NAME like a psychopath.${RESET}"
  echo ""
fi

# ── Monday motivation ────────────────────────────────────────
QUOTES=(
  "Coffee loaded. Soul not included. Let's ship."
  "The JIRA board missed you. It left 12 unread comments."
  "48 hours of freedom: spent. Stack coming back online."
  "Your PRs didn't review themselves. Shocking, I know."
  "Another week, another sprint that 'should be straightforward'."
  "Fresh week. Same bugs. New excuses. Let's go."
  "The standup is in 60 minutes. You've been warned."
  "Remember: it's not a bug, it's an undocumented feature. Now boot up."
)

if [[ "$DOW" -eq 1 ]]; then
  QUOTE="${QUOTES[$((RANDOM % ${#QUOTES[@]}))]}"
  echo -e "${BOLD}${MAGENTA}  💬  ${QUOTE}${RESET}"
  echo ""
fi

# ── 1. Start Colima ──────────────────────────────────────────
log "🖥️   Waking up Colima..."
hacker_output \
  "bootstrapping lima vm kernel..." \
  "allocating virtual cpu threads..." \
  "mounting virtiofs shared filesystem..." \
  "initialising rosetta 2 translation layer..." \
  "binding container runtime socket to host..." \
  "hypervisor online. docker daemon ready."

if command -v colima &>/dev/null; then
  if colima status &>/dev/null; then
    warn "Colima is already running — skipping start."
  else
    dim "Running: colima start"
    colima start
    success "Colima started. The fans are spinning up."
  fi
else
  warn "Colima not found in PATH — skipping."
fi

echo ""

# ── 2. Sail up ───────────────────────────────────────────────
log "🐳  Bringing Docker back to life..."
hacker_output \
  "pulling image manifests from registry..." \
  "provisioning overlay network bridges..." \
  "mounting named volumes: sail-mysql, sail-redis..." \
  "bootstrapping laravel application container..." \
  "waiting for mysql readiness probe..." \
  "all containers healthy. stack is live."

if [[ -f "$BACKEND_DIR/vendor/bin/sail" ]]; then
  dim "Running: sail up -d"
  cd "$BACKEND_DIR"
  ./vendor/bin/sail up -d
  success "Docker containers are up. The whale is back."
else
  warn "Sail not found at $BACKEND_DIR/vendor/bin/sail — skipping."
fi

echo ""

# ── 3. Git pull staging ──────────────────────────────────────
log "📡  Syncing with staging..."
hacker_output \
  "connecting to remote origin..." \
  "negotiating pack protocol with server..." \
  "counting objects and resolving deltas..." \
  "applying fast-forward merge..." \
  "updating working tree index..." \
  "branch is up to date with origin/staging."

cd "$FRONTEND_DIR"
if git rev-parse --git-dir > /dev/null 2>&1; then
  dim "Running: git pull origin $GIT_BRANCH"
  git pull origin "$GIT_BRANCH" && \
  success "Pulled latest from $GIT_BRANCH. You're up to date." \
    || warn "Git pull failed — check for conflicts or remote changes."
else
  warn "Not a git repo at $FRONTEND_DIR — skipping pull."
fi

echo ""

# ── 4. npm run dev ───────────────────────────────────────────
log "⚡  Firing up the Next.js dev server..."
hacker_output \
  "resolving node_modules dependency tree..." \
  "compiling typescript declaration files..." \
  "bundling webpack entry points..." \
  "binding hot module replacement server..." \
  "attaching file system watcher..." \
  "next.js dev server launching at localhost:3000."

echo ""
echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${CYAN}║  🚀  Stack is live. Time to make something.              ║${RESET}"
echo -e "${BOLD}${CYAN}╚══════════════════════════════════════════════════════════╝${RESET}"
echo ""

FRIDAY_DOW=5
HOURS_LEFT=$(( (FRIDAY_DOW - DOW) * 24 ))
if [[ "$HOURS_LEFT" -gt 0 ]]; then
  echo -e "${DIM}  ~${HOURS_LEFT} hours until Friday. You got this (probably).${RESET}"
elif [[ "$DOW" -eq 5 ]]; then
  echo -e "${DIM}  It's Friday. The finish line is visible. Don't blow it.${RESET}"
fi

echo ""

dim "Running: npm run dev"
cd "$FRONTEND_DIR"
npm run dev
