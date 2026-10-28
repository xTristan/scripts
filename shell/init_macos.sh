#!/usr/bin/env bash
#
# init_macos.sh - bootstrap a fresh macOS install.
# Safe to re-run: every step checks whether it has already been done.
#
set -euo pipefail

GITHUB_USER="xTristan"
DOTFILES_DIR="$HOME/dotfiles"
SCRIPTS_DIR="$HOME/scripts"
BACKUP_DIR="$HOME/backup/$(date +%Y%m%d-%H%M%S)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

log() { printf '\n==> %s\n' "$*"; }

# Move a real (non-symlink) file out of the way into the backup folder.
backup() {
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
    echo "Backed up $target -> $BACKUP_DIR/"
  fi
}

# link <source> <destination>: back up any existing file, then symlink.
link() {
  local src="$1" dest="$2"
  if [ ! -e "$src" ]; then
    echo "Skipping $dest (missing $src)"
    return 0
  fi
  mkdir -p "$(dirname "$dest")"
  backup "$dest"
  ln -sfn "$src" "$dest"
}

# Clone only if the destination does not exist yet.
clone_if_missing() {
  local url="$1" dest="$2"
  if [ -d "$dest" ]; then
    echo "Already present: $dest"
  else
    git clone --depth=1 "$url" "$dest"
  fi
}

# --- Sanity check -----------------------------------------------------------
if [ "$(uname -s)" != "Darwin" ]; then
  echo "This script is for macOS only." >&2
  exit 1
fi

# --- oh-my-zsh --------------------------------------------------------------
# --unattended: don't switch shells or launch zsh (which would end this script)
# and keep any existing .zshrc.
log "oh-my-zsh"
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Already installed"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Homebrew ---------------------------------------------------------------
log "Homebrew"
if ! command -v brew >/dev/null 2>&1 \
   && [ ! -x /opt/homebrew/bin/brew ] && [ ! -x /usr/local/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Apple Silicon installs to /opt/homebrew, Intel to /usr/local.
if [ -x /opt/homebrew/bin/brew ]; then
  BREW_BIN=/opt/homebrew/bin/brew
else
  BREW_BIN=/usr/local/bin/brew
fi
eval "$("$BREW_BIN" shellenv)"

touch "$HOME/.zprofile"
if ! grep -qF 'brew shellenv' "$HOME/.zprofile"; then
  printf '\neval "$(%s shellenv)"\n' "$BREW_BIN" >> "$HOME/.zprofile"
fi

# --- Apps and CLI tools -----------------------------------------------------
# brew bundle skips anything that is already installed.
log "Installing apps and tools"
brew bundle --file=- <<'EOF'
tap "nikitabobko/tap"

# CLI tools
brew "git"
brew "gh"                      # GitHub CLI
brew "emacs"
brew "powerlevel10k"

# Apps
cask "iterm2"
cask "ghostty"                 # terminal emulator
cask "google-chrome"
cask "unnaturalscrollwheels"   # separate scroll direction for mouse and trackpad
cask "nikitabobko/tap/aerospace"  # tiling window manager
cask "finicky"                 # route links to specific browsers/profiles

# Font for powerlevel10k
cask "font-meslo-lg-nerd-font"
EOF

# --- GitHub login -----------------------------------------------------------
# Needed to clone private repos. Create a token at
# https://github.com/settings/personal-access-tokens if prompted.
log "GitHub authentication"
if ! gh auth status >/dev/null 2>&1; then
  gh auth login
fi

# --- Dotfiles and scripts ---------------------------------------------------
log "Cloning dotfiles and scripts"
[ -d "$DOTFILES_DIR" ] || gh repo clone "$GITHUB_USER/dotfiles" "$DOTFILES_DIR"
[ -d "$SCRIPTS_DIR" ] || gh repo clone "$GITHUB_USER/scripts" "$SCRIPTS_DIR"

# --- Emacs packages ---------------------------------------------------------
log "Emacs packages"
if [ -f "$SCRIPTS_DIR/emacs/install-package.el" ]; then
  emacs --batch --script "$SCRIPTS_DIR/emacs/install-package.el"
else
  echo "Skipping: $SCRIPTS_DIR/emacs/install-package.el not found"
fi

# --- Symlink dotfiles -------------------------------------------------------
log "Linking dotfiles"
mkdir -p "$ZSH_CUSTOM" "$HOME/.emacs.d"

link "$DOTFILES_DIR/.aliases"            "$ZSH_CUSTOM/aliases.zsh"
link "$DOTFILES_DIR/zsh/.zshrc"          "$HOME/.zshrc"
link "$DOTFILES_DIR/git/.gitconfig"      "$HOME/.gitconfig"
link "$DOTFILES_DIR/emacs/.emacs"        "$HOME/.emacs"
link "$DOTFILES_DIR/emacs/common.el"     "$HOME/.emacs.d/common.el"
link "$DOTFILES_DIR/.aerospace.toml"     "$HOME/.aerospace.toml"

# --- Terminal colors --------------------------------------------------------
log "Terminal color schemes"
mkdir -p "$HOME/.config"
clone_if_missing https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell"
clone_if_missing https://github.com/mbadolato/iTerm2-Color-Schemes.git "$HOME/.config/iTerm2-Color-Schemes"

# --- Done -------------------------------------------------------------------
cat <<EOF

All done. Remaining manual steps (these need an interactive zsh session):

  1. Open a NEW terminal window (or run: exec zsh).
  2. Run: p10k configure
  3. In iTerm2 > Settings > Profiles > Text, set the font to "MesloLGS Nerd Font".
  4. In iTerm2 > Settings > Profiles > Colors > Color Presets > Import, choose
     Afterglow from ~/.config/iTerm2-Color-Schemes/schemes/
  5. Pick a base16 shell theme, e.g.: base16_decaf
     (needs this in your dotfiles .zshrc:)
       BASE16_SHELL="\$HOME/.config/base16-shell/"
       [ -n "\$PS1" ] && [ -s "\$BASE16_SHELL/profile_helper.sh" ] && \\
         source "\$BASE16_SHELL/profile_helper.sh"
  6. Make sure your dotfiles .zshrc loads powerlevel10k:
       source "\$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"

Any replaced files were backed up to: $BACKUP_DIR
EOF
