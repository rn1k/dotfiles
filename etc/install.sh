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

curl -sL https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

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

PATH="$PATH:~/bin"

for dotfile in `ls -Fa $DOTPATH | grep -v / |  grep "^\."`
do
ln -sfvn $DOTPATH/$dotfile $dotfile
done

exec $SHELL -l
