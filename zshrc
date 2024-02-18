# vim:ft=zplug

if [ `uname` = "Linux" ]; then
    export ZPLUG_HOME=~/.zplug/init.zsh
elif [ `uname` = "Darwin" ]; then
    export ZPLUG_HOME=/opt/homebrew/opt/zplug
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

source ${ZPLUG_HOME}/init.zsh

autoload -U compinit && compinit

PATH="$PATH:`pwd`/.dotfiles/bin"



alias vim="nvim"
export XDG_CONFIG_HOME=$HOME/.config

#-----------------------------------------

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY

# history-select
peco-select-history() {
        BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
        CURSOR=${#BUFFER}
        zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#-----------------------------------------

function vimpt(){
    vim `pt $1 | peco | cut -d : -f 1`
}

alias vp="vimpt"

function vim-open(){
    res=$(ls | peco)
    if [ -n "$res" ]; then
      BUFFER+="vim $res"
      zle accept-line
    fi
}

zle -N vim-open
bindkey '^v' vim-open

#-----------------------------------------

alias pssh="peco-ssh"

function peco-ssh() {
    # select ssh host from ~/.ssh/known_hosts
    local res host
    if [ "${1}" = "" ]; then
        res=$(awk '{print $1}' ~/.ssh/known_hosts | awk -F "," '{print $1}' | grep 'co\.jp' | peco)
    else
        res=$(awk '{print $1}' ~/.ssh/known_hosts | awk -F "," '{print $1}' | grep ${1} | peco)
    fi
    if [ -n "$res" ]; then
      BUFFER+="ssh -A $res"
      zle accept-line
    fi
}
zle -N peco-ssh
bindkey '^s' peco-ssh

#-----------------------------------------

function peco-z-search
{
  which peco z > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install peco and z"
    return 1
  fi
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}
zle -N peco-z-search
bindkey '^f' peco-z-search

#-----------------------------------------

function peco-lscd() {
    local dir="$( find . -maxdepth 1 -type d | sed -e 's;\./;;' | peco )"
    if [ ! -z "$dir" ] ; then
        BUFFER+="cd $dir"
        zle accept-line
    fi
}
zle -N peco-lscd
bindkey '^w' peco-lscd

ENHANCD_FILTER=fzy:fzf:peco
export ENHANCD_FILTER

#-----------------------------------------

zplug "plugins/git",   from:oh-my-zsh

zplug "modules/prompt", from:prezto
zstyle ':prezto:module:prompt' theme 'paradox'

zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"

zplug "glidenote/hub-zsh-completion"
zplug 'Valodim/zsh-curl-completion'

zplug "stedolan/jq", \
    as:command, \
    from:gh-r, \
    rename-to:jq

zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:"fzf", \
    frozen:1

zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

zplug "monochromegane/the_platinum_searcher", \
    as:command, \
    from:gh-r, \
    rename-to:"pt", \
    frozen:1

zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1

zplug "rupa/z", use:"z.sh"

zplug 'BurntSushi/ripgrep', \
    from:gh-r, \
    as:command, \
    rename-to:"rg"

zplug "motemen/ghq", \
    as:command, \
    from:gh-r, \
    rename-to:ghq

zplug 'b4b4r07/tmux-powertools', \
    hook-load:'tmux-loader'

#zplug 'b4b4r07/git-powertools', \
#    as:command, \
#    use:'bin/*'

zplug 'b4b4r07/fzf-powertools', \
    as:command, \
    use:'re'

#zplug 'b4b4r07/zsh-history', defer:3, use:init.zsh
zplug 'b4b4r07/zsh-history', as:command, use:misc/fzf-wrapper.zsh, rename-to:ff
if zplug check 'b4b4r07/zsh-history'; then
    export ZSH_HISTORY_FILE="$HOME/.zsh_history.db"
    ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
    ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
    ZSH_HISTORY_KEYBIND_SCREEN="^r^r"
    ZSH_HISTORY_KEYBIND_ARROW_UP="^p"
    ZSH_HISTORY_KEYBIND_ARROW_DOWN="^n"
fi

zplug 'b4b4r07/git-fzf', hook-build:'make'
zplug 'b4b4r07/git-fzf', \
    as:command, \
    use:'bin/(git-*).zsh', \
    rename-to:'$1'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose
