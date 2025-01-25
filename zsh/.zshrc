# Set up Oh My Posh with a custom prompt
#if which oh-my-posh > /dev/null; then
#  export POSH_THEME="$DOTFILES_DEST_DIR/zsh/custom-prompt.psh"  # Use the prompt in your project
#  eval "$(oh-my-posh init zsh --config $POSH_THEME)"
#fi


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

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh)"
fi

# Set a custom prompt with a blue gradient (using Oh My Posh)
PROMPT='%F{33}d%f%F{39}e%f%F{38}v%f%F{44}i%f%F{50}n%f%F{45}k%f%F{44}l%f%F{39}e%f%F{38}p%f%F{43}p%f%F{44}@%f%F{43}m%f%F{44}a%f%F{50}c%f%F{44}:%~%f %F{45}%#%f $(git branch --show-current 2>/dev/null | sed "s/^/ %F{green}/")%F{reset}'

