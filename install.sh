#!/usr/bin/env bash
#
# install.sh - Install packages and stow dotfiles
#
# Run this script from the root of your dotfiles repo, e.g.:
#   ~/dotfiles/install.sh
#
# It expects your dotfiles repo to be laid out as stow "packages", e.g.:
#   dotfiles/
#     nvim/.config/nvim/...
#     zsh/.zshrc
#     tmux/.config/tmux/tmux.conf
#
set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# Packages to install from the official repos via pacman
PACMAN_PACKAGES=(
  git
  stow
  base-devel
  nvim
  zoxide
  starship
  npm
  tailscale
  ntfs-3g
  wl-clipboard
  lact
  discord
  nvim
  code
  lazygit
  make
  cmake
  ninja

  #c++
  raylib

  #osdev
  nasm

  #embedded
  arm-none-eabi-newlib
  arm-none-eabi-gcc
  arm-none-eabi-gdb
  arm-none-eabi-binutils
  stlink
  #python
  uv

  #logic analyzer
  sigrok-cli pulseview sigrok-firmware-fx2lafw
)

# Packages to install from the AUR via yay
YAY_PACKAGES=(
)

# Folders (stow "packages") in this repo to symlink into $HOME.
# Leave empty to auto-detect every top-level directory in the repo.
STOW_PACKAGES=(
  nvim
  kitty
  fish
  starship

)

# Directory where this script lives (assumed to be the dotfiles root)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Target for stow (usually $HOME)
STOW_TARGET="${HOME}"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

log() { printf '\033[1;34m[+]\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$1"; }
err() { printf '\033[1;31m[x]\033[0m %s\n' "$1" >&2; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1
}

# ---------------------------------------------------------------------------
# Package installation
# ---------------------------------------------------------------------------

install_pacman_packages() {
  if [ "${#PACMAN_PACKAGES[@]}" -eq 0 ]; then
    warn "No pacman packages defined, skipping."
    return
  fi

  log "Updating package database..."
  sudo pacman -Sy

  log "Installing pacman packages: ${PACMAN_PACKAGES[*]}"
  sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"
}

install_yay() {
  if require_cmd yay; then
    return
  fi

  warn "yay not found, installing it from AUR..."
  local tmp_dir
  tmp_dir="$(mktemp -d)"

  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
  (
    cd "$tmp_dir/yay"
    makepkg -si --noconfirm
  )
  rm -rf "$tmp_dir"
}

install_yay_packages() {
  if [ "${#YAY_PACKAGES[@]}" -eq 0 ]; then
    warn "No AUR packages defined, skipping."
    return
  fi

  install_yay

  log "Installing AUR packages: ${YAY_PACKAGES[*]}"
  yay -S --needed --noconfirm "${YAY_PACKAGES[@]}"
}

# ---------------------------------------------------------------------------
# Stow dotfiles
# ---------------------------------------------------------------------------

stow_dotfiles() {
  if ! require_cmd stow; then
    err "stow is not installed. It should have been installed via pacman."
    exit 1
  fi

  local packages=("${STOW_PACKAGES[@]}")

  # Auto-detect if no packages were explicitly configured
  if [ "${#packages[@]}" -eq 0 ]; then
    log "STOW_PACKAGES is empty, auto-detecting top-level folders..."
    packages=()
    for dir in "$DOTFILES_DIR"/*/; do
      name="$(basename "$dir")"
      case "$name" in
      .git | install.sh) continue ;;
      esac
      packages+=("$name")
    done
  fi

  log "Stowing packages: ${packages[*]}"
  cd "$DOTFILES_DIR"

  for pkg in "${packages[@]}"; do
    if [ ! -d "$pkg" ]; then
      warn "Package '$pkg' not found in $DOTFILES_DIR, skipping."
      continue
    fi
    log "Stowing '$pkg' -> $STOW_TARGET"
    if ! stow --restow --target="$STOW_TARGET" "$pkg" 2>/tmp/stow_err.log; then
      warn "Conflicts found for '$pkg' (expected conflict, auto-resolving with --adopt):"
      cat /tmp/stow_err.log

      read -rp "Delete existing real folder(s) for '$pkg' and use a clean folder-level symlink instead? [Y/n] " reply
      reply="${reply:-Y}"

      if [[ "$reply" =~ ^[Yy]$ ]]; then
        # Only remove real dirs whose basename matches the package name (e.g. .config/fish),
        # to avoid deleting shared parent dirs like .config
        while IFS= read -r -d '' item; do
          rel="${item#"$pkg"/}"
          target="$STOW_TARGET/$rel"
          if [ -d "$target" ] && [ ! -L "$target" ]; then
            log "Removing existing real directory: $target"
            rm -rf "$target"
          fi
        done < <(find "$pkg" -mindepth 1 -type d -name "$pkg" -print0)

        stow --target="$STOW_TARGET" "$pkg"
      else
        warn "Falling back to --adopt for '$pkg'..."
        stow --adopt --target="$STOW_TARGET" "$pkg"
        log "Restoring tracked versions of '$pkg' (discarding adopted changes)..."
        git -C "$DOTFILES_DIR" restore -- "$pkg"
      fi
    fi
  done
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
  log "Dotfiles directory: $DOTFILES_DIR"

  install_pacman_packages
  install_yay_packages
  stow_dotfiles

  log "Done! Your packages are installed and dotfiles are stowed."
}

main "$@"
