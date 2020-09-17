sudo apt-get update && sudo apt-get install -f

# Temporary backup folders
mkdir ~/backup

# Utilities
sudo apt-get install tmux


sudo apt-get install emacs25
sudo apt-get install google-chrome-stable
sudo apt install pv
sudo apt install unity-tweak-tool
sudo apt-get install checkinstall
sudo apt-get install buildessential
sudo apt-get install git
sudo apt-get install curl

# Download my own dotfiles and scripts
git clone https://github.com/xTristan/dotfiles.git
git clone https://github.com/xTristan/scripts.git

## Terminal - Tilix
sudo apt-get install tilix
## load tilix conifguration
dconf load /com/gexperts/Tilix/ < dotfiles/tilix.dconf ## "dconf dump" to export

## Zsh and oh-my-zsh
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
### Install powerlevel9k
# sudo apt-get install zsh-theme-powerlevel9k
# echo 'source  /usr/share/powerlevel9k/powerlevel9k.zsh-theme' >> ~/.zshrc
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
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
mkdir $HOME/.emacs.d

## copy git versions
ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/emacs/.emacs $HOME/.emacs
ln -s $HOME/dotfiles/emacs/common.el $HOME/.emacs.d/common.el
ln -s $HOME/dotfiles/.Xresources $HOME/.Xresources
# optional, depends on machine
# mkdir $HOME/.confg/gtk-3.0 && ln -s $HOME/dotfiles/gtk-3.0/gtk.css $HOME/.config/gtk-3.0/gtk.css
# sudo mkdir /etc/X11/xorg.conf.d/ && sudo ln $HOME/dotfiles/90-touchpad.conf /etc/X11/xorg.conf.d/90-touchpad.conf

## Install Base16 scheme
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# install i3, does not work on debian, needs manual install.
# sudo add-apt-repository ppa:kgilmer/speed-ricer
# sudo apt-get update
# sudo apt install i3-gaps

# Manual install: https://github.com/Airblader/i3/wiki/Building-from-source
# Install dependencies:
# sudo apt install dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
# clone the repository
# git clone https://www.github.com/Airblader/i3 i3-gaps
# cd i3-gaps

# compile & install
# autoreconf --force --install
# rm -rf build/
# mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
# ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
# make
# sudo make install

# install polybar, does not work on debian, needs manual install.
sudo apt install polybar
sudo gunzip /usr/share/doc/polybar/config.gz
mkdir $HOME/.config/polybar
cp /usr/share/doc/polybar/config $HOME/.config/polybar/config

# install compton, does not work on debian, needs manual install.
sudo apt install compton

# Install i3lock-color dependency
git clone https://github.com/PandorasFox/i3lock-color backup/i3lock-color && cd backup/i3lock-color;
autoreconf -i; ./configure;
make; sudo checkinstall --pkgname=i3lock-color --pkgversion=1 -y;

# back to root
cd ~/

# Install rofi, feh
sudo apt-get install rofi, feh

# Delete the repro
# cd .. && sudo rm -r i3lock-color;

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
sudo cp dotfiles/90-touchpad.conf /etc/X11/xorg.conf.d
