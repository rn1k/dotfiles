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

if [ `uname` = "Linux" ]; then
    git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"
    for dotfile in `ls -Fa $DOTPATH | grep -v / |  grep -v .md`
    do
        ln -sfvn $DOTPATH/$dotfile .$dotfile
    done
    v=`cat /etc/redhat-release | sed -e 's/.*\s\([0-9]\)\..*/\1/'`;
    ln -s `pwd`/.dotfiles/bin/tmux_centos${v} .dotfiles/bin/tmux;
    # zplug
    echo "install zplug..."
    curl -sL https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    # neovim
    echo "install neovim..."
    sudo yum -y install epel-release
    sudo curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
    sudo yum -y install neovim
elif [ `uname` = "Darwin" ]; then
    git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"
    for dotfile in `ls -Fa $DOTPATH | grep -v / |  grep -v .md`
    do
        ln -sfvn $DOTPATH/$dotfile .$dotfile
    done
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install zsh
    brew install zsh-completion
    brew install yarn
    brew install tmux
    brew install zplug
    brew install neovim
    brew tap sanemat/font
    brew install ricty --with-powerline
    cp -f /opt/homebrew/share/fonts/Ricty*.ttf ~/Library/Fonts/
    fc-cache -vf
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
