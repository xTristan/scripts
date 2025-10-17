sudo apt-get update && sudo apt-get install -f

# Temporary backup folders
mkdir ~/backup
mkdir ~/tmp
mkdir ~/tmp/fonts/

# Utilities
sudo apt-get install tmux
sudo apt-get install emacs
sudo apt-get install google-chrome-stable
sudo apt-get install pv gnome-tweak-tool unity-tweak-tool checkinstall build-essential git curl tilix gh

## Zsh and oh-my-zsh
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Git login
# Generate a token here https://github.com/settings/personal-access-tokens
gh auth login # Use https auth instead of ssh

# Download my own dotfiles and scripts
git clone https://github.com/xTristan/dotfiles.git
git clone https://github.com/xTristan/scripts.git

## Load tilix conifguration
dconf load /com/gexperts/Tilix/ < dotfiles/tilix.dconf ## "dconf dump" to export

## Install Emacs package
emacs --batch --script $HOME/scripts/emacs/install-package.el

### Install power10k scheme
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P tmp/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P tmp/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P tmp/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P tmp/fonts/

cp tmp/fonts/*.ttf /usr/local/share/fonts

### Install powerlevel10k
### https://github.com/romkatv/powerlevel10k
cd tmp/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"


### Install Nerd Fonts
# git clone https://github.com/ryanoasis/nerd-fonts.git ~/backups/ # too much. This takes ~5G
# cd ~/backups/nerd-fonts

### Selectively install nerd fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
fc-cache -fv

# copy dotfiles
## make backups of vanila files
mv ~/.bashrc ~/backup/
mv ~/.bash_aliases ~/backup/
mv ~/.bash_profiles ~/backup/
mv ~/.zshrc ~/backup/
mv ~/.tmux.conf ~/backup/
mv ~/.Xresources ~/backup/
mv ~/.emacs ~/backup/
mkdir ~/backup/zsh_custom/
mv $ZSH_CUSTOM/aliases.zsh ~/backup/zsh_custom/
mkdir $HOME/.emacs.d

## copy git versions
# ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
# ln -s $HOME/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $HOME/dotfiles/.aliases $ZSH_CUSTOM/aliases.zsh
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/emacs/.emacs $HOME/.emacs
ln -s $HOME/dotfiles/emacs/common.el $HOME/.emacs.d/common.el

##  Only configure these for laptop with trackpad
# ln -s $HOME/dotfiles/.Xresources $HOME/.Xresources
# See: https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder
# sudo ln -s $HOME/dotfiles/xorg.conf /etc/X11/xorg.conf
# optional, depends on machine
# mkdir $HOME/.confg/gtk-3.0 && ln -s $HOME/dotfiles/gtk-3.0/gtk.css $HOME/.config/gtk-3.0/gtk.css
# sudo mkdir /etc/X11/xorg.conf.d/ && sudo ln $HOME/dotfiles/90-touchpad.conf /etc/X11/xorg.conf.d/90-touchpad.conf

# Make LS_COLORS prettier
## Install Base16 scheme
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

## Make sure the following is in .zshrc
# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#        source "$BASE16_SHELL/profile_helper.sh"

## Set a nice them.
base16_decaf

# Consider trying this: https://github.com/trapd00r/LS_COLORS for LS color in terminal

# copy .tmux.conf
# copy .emacs
# copy bash.rc, bash.profile
# copy terminial profiles
# dconf load /com/gexperts/Tilix/ < $DROPBOX_FOLDER/dotfiles/tilix.dconf
# install i3
# install polybar
# install compton

# install i3, does not work on debian, needs manual install.
# sudo add-apt-repository ppa:kgilmer/speed-ricer
# sudo apt-get update
# sudo apt install i3-gaps

# Manual install: https://github.com/Airblader/i3/wiki/Building-from-source
# https://lottalinuxlinks.com/how-to-build-and-install-i3-gaps-on-debian/
sudo apt purge i3
## Install dependencies:
sudo apt install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
## sudo apt install dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
rm -rf build/
mkdir -p build && cd build/
meson ..
ninja
sudo ninja install
# verify installation with which i3
which i3
mkdir ~/.config/i3/
ln -s ~/dotfiles/i3/config ~/.config/i3/config


########  BEGIN OF Stale. Ignore ####### 
# autoreconf --force --install
# rm -rf build/
# mkdir -p build && cd build/

### Install powerlevel9k
# sudo apt-get install zsh-theme-powerlevel9k
# echo 'source  /usr/share/powerlevel9k/powerlevel9k.zsh-theme' >> ~/.zshrc
# git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k


# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
# ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
# make
# sudo make install
########  END OF Stale. Ignore ####### 

# install polybar, does not work on debian, needs manual install.
sudo apt install polybar
# sudo gunzip /usr/share/doc/polybar/config.gz
# mkdir $HOME/.config/polybar
# cp /usr/share/doc/polybar/config $HOME/.config/polybar/config

# install compton, does not work on debian, needs manual install.
sudo apt install compton

# Install i3lock-color dependency
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/PandorasFox/i3lock-color backup/i3lock-color && cd backup/i3lock-color 
./install-i3lock-color.sh 
# alternatively: https://github.com/Raymo111/i3lock-color

# Delete the repro
# cd .. && sudo rm -r i3lock-color;

# back to $HOME
cd ~/

# Install rofi, feh
sudo apt-get install rofi feh


# Set up background wallpaper is different each time
# e.g export WALLPAPER_ROOT=/media/xtristan/OS/Users/Jian/Dropbox/Photos/Wallpaper
ln -s $WALLPAPER_ROOT Pictures/Wallpapers
betterlockscreen -u ~/Pictures/Wallpapers

# Install betterlockscreen
# sudo apt-get install checkinstall bc imagemagick libjpeg-dev libpam0g-dev libxcb-composite0 libxcb-composite0-dev \
#    libxcb-image0-dev libxcb-randr0 libxcb-util-dev libxcb-xinerama0 libxcb-xinerama0-dev libxcb-xkb-dev \
#    libxkbcommon-x11-dev feh libev-dev autoconf libxcb-xrm-dev;
git clone https://github.com/pavanjadhaw/betterlockscreen backup/betterlockscreen
mkdir ~/.local/bin/
cp backup/betterlockscreen/betterlockscreen ~/.local/bin/
# Only necessary if first time setup 
# cp examples/betterlockscreenrc ~/dotfiles/i3/
ln -s ~/dotfiles/i3/betterlockscreenrc ~/.config/

# Tweak betterlockscreen script
# em $HOME/.local/bin/betterlockscreen
# Adjust indpos for the distance between the ring and the clock (instantaneous)
# Adjust the rectangle size in the betterlockscreen script. 
# Requires update the cache with: betterlockscreen -u Pictures/Wallpapers

# Update trackpad
sudo mkdir -p /etc/X11/xorg.conf.d
sudo cp dotfiles/*.conf /etc/X11/xorg.conf.d

sudo apt-get update; sudo apt-get install xbacklight alsa-utils pulseaudio
# if running into this error: libxcb-util.so.0: cannot open shared object file: No such file or directory
# sudo ln -s /usr/lib/x86_64-linux-gnu/libxcb-util.so.1 /usr/lib/x86_64-linux-gnu/libxcb-util.so.0


