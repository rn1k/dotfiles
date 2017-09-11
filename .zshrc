# vim:ft=zplug

source ~/.zplug/init.zsh

autoload -U compinit && compinit

zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "b4b4r07/enhancd", use:init.sh
zplug "b4b4r07/zsh-vimode-visual", use:"*.zsh", defer:3
zplug "zsh-users/zsh-completions"
#zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2

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

zplug "monochromegane/the_platinum_searcher", \
    as:command, \
    from:gh-r, \
    rename-to:"pt", \
    frozen:1

zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1

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

zplug load --verbose
