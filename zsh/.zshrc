# Set up Zsh plugins
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gp="git push"
alias gpl="git pull"
alias gs="git status"
alias gl="git log"

# Enhanced 'ls' command using 'lsd'
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -lA"
alias lt="lsd -lt"

# Other useful Zsh settings
export ZSH_HISTORY_SIZE=10000
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:ps:history"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/src/dotfiles/zsh/custom-prompt.json)"
fi
