#!/usr/bin/env bash

# ============================================================
# config.sh — user configuration for weekendify + mondayify
# ============================================================
# This is the ONLY file you need to edit.
# Change names, cheat codes, and paths here.
# Then re-run install.sh to apply.
# ------------------------------------------------------------
# Author  : Hafeez Mohamad
# LinkedIn: https://www.linkedin.com/in/hafeez-mohamad/
# ============================================================

# ── Command names ────────────────────────────────────────────
# These become the global terminal commands after install.
# Change them to anything you like.
#
#   weekendify   →  the shutdown script
#   mondayify    →  the boot-up script
#
WEEKENDIFY_CMD="weekendify"
MONDAYIFY_CMD="mondayify"

# ── Cheat codes (day-guard bypass) ───────────────────────────
# Type these as an argument to override the day check.
# Any single word works — defaults are GTA Vice City cheats.
#
#   weekendify LEAVEMEALONE   →  run on a weekday
#   mondayify  ASPIRINE       →  run on a weekend
#
WEEKENDIFY_CHEAT="LEAVEMEALONE"
MONDAYIFY_CHEAT="ASPIRINE"

# ── Project paths ─────────────────────────────────────────────
# Point these at your own frontend and backend directories.
#
FRONTEND_DIR="/frontend"
BACKEND_DIR="/backend"

# ── Git branch ───────────────────────────────────────────────
# The branch mondayify pulls from on startup.
#
GIT_BRANCH="staging"
