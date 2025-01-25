#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

DOTFILES_REPO_URL="https://github.com/DevinKlepp/dotfiles.git"
DOTFILES_DEST_DIR="$HOME/src/dotfiles"
NERD_FONT_NAME="Hack Nerd Font"
ITERM_PROFILE_NAME="Default"

echo "Starting setup..."

if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing now..."

  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Determine the architecture and add Homebrew to the appropriate PATH
  if [[ -d "/opt/homebrew/bin" ]]; then
    # For M Series Macs (ARM architecture)
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -d "/usr/local/bin" ]]; then
    # For Intel Macs (x86 architecture)
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  echo "Homebrew installed and added to PATH."
else
  echo "Homebrew is already installed."
fi

# Install Git if not installed
if ! command -v git &> /dev/null; then
  echo "Git is not installed. Installing Git..."
  brew install git
else
  echo "Git is already installed."
fi

# Check if the dotfiles repository already exists, and remove it if it does
if [ -d "$DOTFILES_DEST_DIR" ]; then
  echo "Dotfiles repository already exists. Removing it..."
  rm -rf "$DOTFILES_DEST_DIR"
fi

# Clone dotfiles repository if not already cloned
if [ ! -d "$DOTFILES_DEST_DIR" ]; then
  echo "Cloning dotfiles repository to $DOTFILES_DEST_DIR..."
  mkdir -p "$HOME/src"
  git clone "$DOTFILES_REPO_URL" "$DOTFILES_DEST_DIR"
else
  echo "Dotfiles repository is already cloned."
fi

# Change directory to the dotfiles repository
cd "$DOTFILES_DEST_DIR"

# Install iTerm2
if ! brew list --cask | grep -q "^iterm2$"; then
  echo "Installing iTerm2..."
  brew install --cask iterm2
else
  echo "iTerm2 is already installed."
fi

# Set iTerm2 as the default terminal
echo "Setting iTerm2 as the default terminal..."
defaults write com.apple.terminal "Default Window Settings" -string "$ITERM_PROFILE_NAME"
defaults write com.apple.terminal "Startup Window Settings" -string "$ITERM_PROFILE_NAME"
open -a iTerm

# Install Nerd Font
if ! ls ~/Library/Fonts | grep -q "$NERD_FONT_NAME"; then
  echo "Installing Nerd Font..."
  brew tap homebrew/cask-fonts-nerd
  brew install --cask font-hack-nerd-font
else
  echo "Nerd Font is already installed."
fi


# Install Oh My Posh
if ! command -v oh-my-posh &> /dev/null; then
  echo "Installing Oh My Posh..."
  brew install oh-my-posh
else
  echo "Oh My Posh is already installed."
fi

# Install Zsh plugins
if ! brew list | grep -q "^zsh-autosuggestions$"; then
  echo "Installing zsh-autosuggestions..."
  brew install zsh-autosuggestions
else
  echo "zsh-autosuggestions is already installed."
fi

if ! brew list | grep -q "^zsh-syntax-highlighting$"; then
  echo "Installing zsh-syntax-highlighting..."
  brew install zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting is already installed."
fi

# Install lsd
if ! command -v lsd &> /dev/null; then
  echo "Installing lsd..."
  brew install lsd
else
  echo "lsd is already installed."
fi

# Set Zsh as the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting Zsh as the default shell..."
  chsh -s "$(which zsh)"
else
  echo "Zsh is already the default shell."
fi

# Create ~/src directory if it doesn't exist
if [ ! -d ~/src ]; then
  echo "Creating ~/src directory..."
  mkdir -p ~/src
else
  echo "~/src directory already exists."
fi

# Symlink .zshrc if not already linked
if [ ! -L ~/.zshrc ]; then
  echo "Setting up .zshrc..."
  ln -sf "$DOTFILES_DEST_DIR/zsh/.zshrc" ~/.zshrc
else
  echo ".zshrc is already set up."
fi

# Symlink Oh My Posh prompt config if not already linked
if [ ! -L ~/.poshthemes/custom-prompt.psh ]; then
  echo "Setting up Oh My Posh prompt..."
  mkdir -p ~/.poshthemes
  ln -sf "$DOTFILES_DEST_DIR/zsh/custom-prompt.psh" ~/.poshthemes/custom-prompt.psh
else
  echo "Oh My Posh prompt is already set up."
fi

# Configure iTerm2 to use Nerd Font
echo "Configuring iTerm2 to use Nerd Font..."
defaults write com.googlecode.iterm2 "Normal Font" -string "$NERD_FONT_NAME 12"
defaults write com.googlecode.iterm2 "Non-ASCII Font" -string "$NERD_FONT_NAME 12"

# Reload Zsh configuration
echo "Reloading .zshrc..."
source ~/.zshrc

echo "Setup complete! Restart your terminal or source your .zshrc for changes to take effect."
