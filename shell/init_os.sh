sudo apt-get update && sudo apt-get install -f

## Utilities
sudo apt-get install tmux
sudo apt-get install emacs24
sudo apt-get install google-chrome-stable
sudo apt install pv
sudo apt install unity-tweak-tool

## Install Base16 scheme
sudo apt-get install git
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

## Install web development tools
sudo apt-get install apache2
## sudo apt install libapache2-mod-*
sudo apt-get install mysql-server
## Restart MySql Server
## sudo systemctl restart mysql.service
## Root pwd: UnivPwd+MyBD

sudo apt install mysqltuner

sudo apt-get install nautilus-dropbox
dropbox start -i

// copy .tmux.conf
// copy .emacs
// copy bash.rc, bash.profile
// copy terminial profiles
// install i3
// install polybar
// install compton

// install betterlockscreen
git clone https://github.com/pavanjadhaw/betterlockscreen
cd betterlockscreen
cp betterlockscreen ~/.local/bin/
