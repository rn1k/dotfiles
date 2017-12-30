#!/bin/zsh

if [ -e ~/.zprofile ] ; then
    rm  ~/.zprofile*
fi

if [ -e ~/.zshrc ] ; then
    rm  ~/.zshrc*
fi

if [ -e ~/.zplug ] ; then
    rm -rf ~/.zplug*
fi

echo "install zplug..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

if [ -e ~/.vim ] ; then
    rm -rf ~/.vim/*
else
    mkdir ~/.vim
fi

if [ -e ~/.vimrc ] ; then
    rm  ~/.vimrc*
fi

if [ -e ~/.tmux.conf ] ; then
    rm  ~/.tmux.conf*
fi

if [ -e ~/bin/tmux ] ; then
    rm  ~/bin/tmux*
fi

if [ -e ~/bin/pt ] ; then
    rm  ~/bin/pt*
fi

if [ -e ~/bin/peco ] ; then
    rm  ~/bin/peco*
fi

if [ -e ~/bin/tig ] ; then
    rm  ~/bin/tig*
fi

DOTFILES_GITHUB="https://github.com/rn1k/dotfiles.git"
DOTPATH=`pwd`/.dotfiles
git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"

for dotfile in `ls -Fa $DOTPATH | grep -v / |  grep -v .md`
do
  ln -sfvn $DOTPATH/$dotfile .$dotfile
done

if [ `uname`=="Linux" ]; then
  v=`cat /etc/redhat-release | sed -e 's/.*\s\([0-9]\)\..*/\1/'`;
  ln -s `pwd`/.dotfiles/bin/tmux_centos${v} .dotfiles/bin/tmux;
  # neovim
  echo "install neovim..."
  sudo yum -y install epel-release
  sudo curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
  sudo yum -y install neovim
fi

XDG_CONFIG_HOME=$HOME/.config
if [ ! -e $XDG_CONFIG_HOME ] ; then
    mkdir $XDG_CONFIG_HOME
fi

DOTVIMPATH=$DOTPATH/vim
ln -sfvn $DOTVIMPATH/dein.toml $HOME/.vim/dein.toml
ln -sfvn $DOTVIMPATH/dein_lazy.toml $HOME/.vim/dein_lazy.toml
ln -sfvn `pwd`/.vimrc $HOME/.vim/init.vim
ln -sfvn $HOME/.vim $XDG_CONFIG_HOME/nvim

exec $SHELL -l
