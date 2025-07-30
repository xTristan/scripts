# Temporary backup folders
mkdir ~/backup

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install necessary softwares.
brew install iterm2
brew install emacs
brew install --cask google-chrome
brew install git
brew install gh # (GitHub CLi)
# Allow independent control of scrolling for mouse and trackpad.
brew install --cask unnaturalscrollwheels
# Aerospace window management
brew install --cask nikitabobko/tap/aerospace

brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

# Install p10k
## follow this to install font: https://github.com/romkatv/powerlevel10k#manual-font-installation
## Or NerdFonts: https://www.nerdfonts.com/font-downloads
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
## Open ~/.zshrc, find the line that sets ZSH_THEME, eand change its value to "powerlevel10k/powerlevel10k".

p10k configure

# Configure git login credentails
# https://github.com/settings/personal-access-tokens
gh auth login

# Download my own dotfiles and scripts
## Make sure you have your access token ready from https://github.com/settings/personal-access-tokens/
git clone https://github.com/xTristan/dotfiles.git
git clone https://github.com/xTristan/scripts.git

                                                                     │
## Install Emacs package                                              │
emacs --batch --script $HOME/scripts/emacs/install-package.el

# link dotfiles
## make backups of vanila files
# mv ~/.bashrc ~/backup/
# mv ~/.bash_aliases ~/backup/
# mv ~/.bash_profiles ~/backup/
mv ~/.zshrc ~/backup/
mv ~/.emacs ~/backup/
mkdir ~/backup/zsh_custom/
mv $ZSH_CUSTOM/aliases.zsh ~/backup/zsh_custom/
mkdir $HOME/.emacs.d

## symlink dotfiles.
# ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
# ln -s $HOME/dotfiles/.bash_profile $HOME/.bash_profile

ln -s $HOME/dotfiles/.aliases $ZSH_CUSTOM/aliases.zsh
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/emacs/.emacs $HOME/.emacs
ln -s $HOME/dotfiles/emacs/common.el $HOME/.emacs.d/common.el
ln -s $HOME/dotfiles/.aerospace.toml $HOME/.aerospace.toml

# Make LS COLOR prettier
## Install Base16 scheme
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
## Ensure the following is in .zshrc
# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#        source "$BASE16_SHELL/profile_helper.sh"
       
### Set a theme
base_decaf

git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git # Then select afterglow
## Consider trying this https://github.com/trapd00r/LS_COLORS for LS_COLORS

