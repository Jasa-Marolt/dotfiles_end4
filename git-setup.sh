#!/usr/bin/env bash
#
# git-setup.sh - Generate an SSH key and configure global git identity
#
# Usage:
#   ./git-setup.sh "you@example.com" "Your Name"
#
# If arguments are omitted, you'll be prompted for them interactively.

set -euo pipefail

log()  { printf '\033[1;34m[+]\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$1"; }
err()  { printf '\033[1;31m[x]\033[0m %s\n' "$1" >&2; }

# ---------------------------------------------------------------------------
# Gather input
# ---------------------------------------------------------------------------

EMAIL="${1:-}"
NAME="${2:-}"

if [ -z "$EMAIL" ]; then
    read -rp "Enter your email for git/ssh: " EMAIL
fi

if [ -z "$NAME" ]; then
    read -rp "Enter your name for git: " NAME
fi

if [ -z "$EMAIL" ] || [ -z "$NAME" ]; then
    err "Both email and name are required."
    exit 1
fi

# ---------------------------------------------------------------------------
# SSH key generation
# ---------------------------------------------------------------------------

SSH_DIR="$HOME/.ssh"
KEY_NAME="id_ed25519"
KEY_PATH="$SSH_DIR/$KEY_NAME"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ -f "$KEY_PATH" ]; then
    warn "An SSH key already exists at $KEY_PATH"
    read -rp "Overwrite it with a new key? [y/N] " overwrite
    if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
        log "Keeping existing key."
    else
        rm -f "$KEY_PATH" "$KEY_PATH.pub"
        log "Generating new ed25519 SSH key for $EMAIL..."
        ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
    fi
else
    log "Generating ed25519 SSH key for $EMAIL..."
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
fi

# Start ssh-agent and add the key
if [ -z "${SSH_AUTH_SOCK:-}" ]; then
    eval "$(ssh-agent -s)" >/dev/null
fi
ssh-add "$KEY_PATH" 2>/dev/null || warn "Could not add key to ssh-agent (agent may not be running)."

# ---------------------------------------------------------------------------
# Print public key
# ---------------------------------------------------------------------------

echo
log "Your public SSH key ($KEY_PATH.pub):"
echo "----------------------------------------------------------------------"
cat "$KEY_PATH.pub"
echo "----------------------------------------------------------------------"
echo
log "Add this key to GitHub/GitLab/etc: Settings -> SSH Keys -> New SSH Key"

# ---------------------------------------------------------------------------
# Git identity
# ---------------------------------------------------------------------------

log "Setting global git config..."
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"

log "git user.name  = $(git config --global user.name)"
log "git user.email = $(git config --global user.email)"

log "Done!"
