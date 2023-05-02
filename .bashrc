#
# Get CIMS defaults
#
if [ -r /usr/local/lib/.system.bashrc ] ; then
    . /usr/local/lib/.system.bashrc
fi

# Make individual customizations, such as aliases, below.
[ $TERM = 'xterm-kitty' ] && export COLORTERM=truecolor
[ $TMUX ] && printf '\ePtmux;\e\e[<u\e\\' && unset COLORTERM

module load gcc-12.2 python-3.10

if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
  if [ -x "$(command -v fd)" ]; then
    export FZF_DEFAULT_COMMAND='fd --type=file --color=always'
    export FZF_DEFAULT_OPTS='--ansi'
    export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
    export FZF_ALT_C_COMMAND='fd --type=directory'
  fi
  [ -x "$(command -v bat)" ] && export FZF_CTRL_T_OPTS="--preview 'bat --theme=gruvbox-dark --style=numbers --color=always --italic-text=always --line-range=:500 {}'" || export FZF_CTRL_T_OPTS="--preview '(cat {} || tree -C {}) 2> /dev/null | head -500'"
  [ -x "$(command -v lsd)" ] && export FZF_ALT_C_OPTS="--preview 'lsd --tree --color=always --icon=always {} | head -500'" || export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -500'"
fi

export EDITOR="emacsclient -a '' -nw"
export HISTSIZE=100000
export HISTFILESIZE=100000
export LESS='-g -i -M -R -S -w -X -z-4'
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

alias emacs="emacsclient -a '' -nw"
alias ls='ls --color=auto'
if [ -x "$(command -v bat)" ]; then
  alias bat='bat --theme=gruvbox-dark --style=numbers,changes --italic-text=always'
  alias cat='bat --style=plain'
fi
[ -x "$(command -v lsd)" ] && alias ll='lsd --long --blocks=permission,size,date,name --date="+%F %R"'
