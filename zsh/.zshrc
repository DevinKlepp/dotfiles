# Set up Oh My Posh with a custom prompt
if which oh-my-posh > /dev/null; then
  export POSH_THEME=~/.poshthemes/custom-prompt.psh
  oh-my-posh init zsh --config $POSH_THEME | source
fi

# Set up Zsh plugins
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias g="git"
alias ga="git add"
alias gst="git status"
alias gco="git checkout"
alias gl="git log"
alias ga.="git add ."
alias gs="git status"

# Enhanced 'ls' command using 'lsd'
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -lA"
alias lt="lsd -lt"

# Other useful Zsh settings
export ZSH_HISTORY_SIZE=10000
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:ps:history"

# Set a custom prompt with a blue gradient (using Oh My Posh)
PROMPT='%F{blue}%n@%m %F{cyan}%~ %F{green}%(git branch --show-current 2>/dev/null)%F{reset}'
