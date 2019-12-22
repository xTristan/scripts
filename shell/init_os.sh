sudo apt-get update && sudo apt-get install -f

## Utilities
sudo apt-get install tmux
sudo apt-get install tilix
sudo apt-get install emacs25
sudo apt-get install google-chrome-stable
sudo apt install pv
sudo apt install unity-tweak-tool
sudo apt-get install checkinstall
sudo apt-get install buildessential
sudo apt-get install git
sudo apt-get install curl

## Zsh and oh-my-zsh
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# copy dotfiles
## make backups
mkdir ~/backups
mv ~/.bashrc ~/backup/
mv ~/.bash_aliases ~/backup/
mv ~/.bash_profiles ~/backup/
## copy git versions
git clone https://github.com/xTristan/dotfiles.git
ln -s /home/xtristan/dotfiles/.bashrc /home/xtristan/.bashrc
ln -s /home/xtristan/dotfiles/.bash_aliases /home/xtristan/.bash_aliases
ln -s /home/xtristan/dotfiles/.bash_profile /home/xtristan/.bash_profile
## load tilix conifguration
dconf load /com/gexperts/Tilix/ < dotfiles/tilix.dconf ## "dconf dump" to export


## Install Base16 scheme
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# copy .tmux.conf
# copy .emacs
# copy bash.rc, bash.profile
# copy terminial profiles
# install i3
sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt-get update
sudo apt install i3-gaps

# install polybar
# install compton

# install betterlockscreen
sudo apt-get install bc imagemagick libjpeg-dev libpam0g-dev libxcb-composite0 libxcb-composite0-dev \
    libxcb-image0-dev libxcb-randr0 libxcb-util-dev libxcb-xinerama0 libxcb-xinerama0-dev libxcb-xkb-dev \
    libxkbcommon-x11-dev feh libev-dev;
printf "\n";

# Install i3lock-color dependency
git clone https://github.com/PandorasFox/i3lock-color && cd i3lock-color;
autoreconf -i; ./configure;
make; sudo checkinstall --pkgname=i3lock-color --pkgversion=1 -y;
cp examples/betterlockscreenrc ~/dotfiles/i3/
ln -s ~/dotfiles/i3/betterlockscreenrc ~/.config/

# Delete the repro
# cd .. && sudo rm -r i3lock-color;

# Install betterlockscreen
git clone https://github.com/pavanjadhaw/betterlockscreen
cd betterlockscreen
cp betterlockscreen ~/.local/
./betterlockscreen -u ~/Pictures

# Add this line to your ~/.config/i3/config
# bindsym $mod+shift+x exec betterlockscreen -l dim

# Add this line to ~/.config/i3/config
# set desktop background with custom effect
# exec --no-startup-id betterlockscreen -w dim




## Install web development tools
# sudo apt-get install apache2
## sudo apt install libapache2-mod-*
# sudo apt-get install mysql-server
## Restart MySql Server
## sudo systemctl restart mysql.service

# sudo apt install mysqltuner

# sudo apt-get install nautilus-dropbox
# dropbox start -i
