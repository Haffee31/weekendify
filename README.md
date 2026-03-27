# 🌴 weekendify + 💀 mondayify

> Two terminal scripts for developers who take their dev rituals seriously.

`weekendify` shuts your entire dev stack down in one command. `mondayify` boots it all back up. Both come with ASCII banners, fake hacker output, GTA Vice City cheat codes, and zero tolerance for running at the wrong time of week.

Built for macOS with **Colima + Docker/Sail + Next.js** stacks — but configurable for any setup.

---

## What they do

### 🌴 `weekendify`
Runs on **weekends**. Shuts everything down so your laptop can breathe.

1. Kills the Next.js dev server
2. Runs `sail down` to stop all Docker containers
3. Stops Colima (the Docker VM)

### 💀 `mondayify`
Runs on **weekdays**. Boots everything back up so you can get to work.

1. Starts Colima
2. Runs `sail up -d` to start all Docker containers
3. Pulls latest from your configured git branch
4. Launches `npm run dev`

---

## Requirements

| Tool | Purpose |
|------|---------|
| [Colima](https://github.com/abiosoft/colima) | Docker runtime on macOS |
| [Docker](https://www.docker.com/) | Container engine |
| [Laravel Sail](https://laravel.com/docs/sail) | Docker wrapper for Laravel |
| [Node.js + npm](https://nodejs.org/) | Frontend dev server |
| bash 3.2+ | Ships with macOS — no Homebrew needed |

> **Note:** Tools you don't use are skipped gracefully with a warning — you don't need all of them.

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/Haffee31/weekendify.git
cd weekendify
```

### 2. Configure

Open `config.sh` — this is the **only file you need to edit**:

```bash
# Command names (installed to /usr/local/bin)
WEEKENDIFY_CMD="weekendify"
MONDAYIFY_CMD="mondayify"

# Cheat codes to bypass the day guard
WEEKENDIFY_CHEAT="LEAVEMEALONE"
MONDAYIFY_CHEAT="ASPIRINE"

# Your project paths
FRONTEND_DIR="/path/to/your/frontend"
BACKEND_DIR="/path/to/your/backend"

# Branch to pull on mondayify startup
GIT_BRANCH="staging"
```

### 3. Install

```bash
./install.sh
```

This makes all scripts executable and symlinks them into `/usr/local/bin` (or `~/.local/bin` if `/usr/local/bin` isn't writable), so both commands are available globally from any directory.

> If installing to `~/.local/bin`, the installer will tell you if it needs to be added to your `$PATH`.

---

## Usage

```bash
# Shut everything down — weekends only
weekendify

# Force shutdown on a weekday (cheat code)
weekendify LEAVEMEALONE

# Boot everything up — weekdays only
mondayify

# Force boot on a weekend (cheat code)
mondayify ASPIRINE
```

The cheat codes are case-insensitive — `leavemealone` works just as well.

---

## Day guards

Both scripts enforce the right day of the week — because discipline matters.

### `weekendify` on a weekday
```
╔══════════════════════════════════════════════════════════╗
║  🚨  WEEKDAY DETECTED. ABORTING MISSION.                 ║
╚══════════════════════════════════════════════════════════╝

  It's Tuesday. Your Jira tickets are watching.

  Enter the cheat code: weekendify LEAVEMEALONE
```

### `mondayify` on a weekend
```
╔══════════════════════════════════════════════════════════╗
║  🏖️   IT'S THE WEEKEND. WHAT ARE YOU DOING.              ║
╚══════════════════════════════════════════════════════════╝

  It's Saturday. The stack will survive without you.

  If you MUST: mondayify ASPIRINE
```

---

## GTA Vice City cheat codes

The override system is themed around GTA Vice City cheats — because `./script.sh -f` is boring.

| Cheat | Game effect | Script effect |
|-------|------------|---------------|
| `LEAVEMEALONE` | Clears wanted level | Bypasses weekday guard on `weekendify` |
| `ASPIRINE` | Full health restore | Bypasses weekend guard on `mondayify` |

You can change these to anything you want in `config.sh`.

---

## Customisation

All customisation lives in `config.sh`. No other file needs to be touched.

| Variable | Default | Description |
|----------|---------|-------------|
| `WEEKENDIFY_CMD` | `weekendify` | Global command name for the shutdown script |
| `MONDAYIFY_CMD` | `mondayify` | Global command name for the boot script |
| `WEEKENDIFY_CHEAT` | `LEAVEMEALONE` | Override code for weekendify |
| `MONDAYIFY_CHEAT` | `ASPIRINE` | Override code for mondayify |
| `FRONTEND_DIR` | *(your path)* | Absolute path to your frontend directory |
| `BACKEND_DIR` | *(your path)* | Absolute path to your backend directory |
| `GIT_BRANCH` | `staging` | Branch to pull on mondayify startup |

After editing `config.sh`, re-run `./install.sh` to apply any command name changes.

---

## File structure

```
weekendify/
├── config.sh       ← ✏️  edit this — everything else reads from here
├── lib.sh          ← shared colours, helpers, functions
├── weekendify.sh   ← shutdown script
├── mondayify.sh    ← boot-up script
├── install.sh      ← one-time setup
└── README.md
```

---

## Uninstall

```bash
rm /usr/local/bin/weekendify /usr/local/bin/mondayify
```

Or, if installed to `~/.local/bin`:

```bash
rm ~/.local/bin/weekendify ~/.local/bin/mondayify
```

---

## Author

**Hafeez Mohamad**

| | |
|---|---|
| 💼 LinkedIn | [linkedin.com/in/hafeez-mohamad](https://www.linkedin.com/in/hafeez-mohamad/) |
| 🐙 GitHub | [github.com/Haffee31](https://github.com/Haffee31/) |
| 🐦 X / Twitter | [x.com/Hafeez_31](https://x.com/Hafeez_31) |
| 🌐 Website | [haffee.vercel.app/](https://haffee.vercel.app/) |
| 📧 Email | haffeecareer@gmail.com |

---

## License

MIT — do whatever you want with it. Just don't run `mondayify` on a Saturday without the cheat code.
