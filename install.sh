#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

DOTFILES_REPO_URL="https://github.com/DevinKlepp/dotfiles.git"
DOTFILES_DEST_DIR="$HOME/src/dotfiles"
ITERM_PROFILE_NAME="Default"

echo "Starting setup..."

# Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed."
fi

# Install Git
if ! command -v git &>/dev/null; then
  echo "Installing Git..."
  brew install git
fi

# Create ~/src directory if it doesn't exist
if [ ! -d ~/src ]; then
  echo "Creating ~/src directory..."
  mkdir -p ~/src
else
  echo "~/src directory already exists."
fi

# Remove the dotfiles repository if it already exists
if [ -d "$DOTFILES_DEST_DIR" ]; then
  echo "Dotfiles repository already exists. Removing it..."
  rm -rf "$DOTFILES_DEST_DIR"
fi

# Clone the dotfiles repository
echo "Cloning dotfiles repository to $DOTFILES_DEST_DIR..."
[ -d "$HOME/src" ] || mkdir "$HOME/src"
git clone "$DOTFILES_REPO_URL" "$DOTFILES_DEST_DIR"

# Change directory to the dotfiles repository
cd "$DOTFILES_DEST_DIR"

# Install iTerm2
if ! brew list --cask | grep -q "^iterm2$"; then
  echo "Installing iTerm2..."
  brew install --cask iterm2
else
  echo "iTerm2 is already installed."
fi

# Install Nerd Font
if [ ! -f ~/Library/Fonts/"HackNerdFont-Regular.ttf" ]; then
  echo "Installing Nerd Font..."

  # Install Nerd Font using Homebrew
  brew install --cask font-hack-nerd-font

  echo "Nerd Font installed."
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
ZSH_PLUGINS=("zsh-autosuggestions" "zsh-syntax-highlighting")
for plugin in "${ZSH_PLUGINS[@]}"; do
  if ! brew list | grep -q "^$plugin$"; then
    echo "Installing $plugin..."
    brew install "$plugin"
  else
    echo "$plugin is already installed."
  fi
done


# Install lsd
if ! command -v lsd &> /dev/null; then
  echo "Installing lsd..."
  brew install lsd
else
  echo "lsd is already installed."
fi

# Symlink .zshrc if not already linked
if [ ! -L ~/.zshrc ]; then
  echo "Setting up .zshrc..."
  ln -sf "$DOTFILES_DEST_DIR/zsh/.zshrc" ~/.zshrc
else
  echo ".zshrc is already set up."
fi

echo "Setup complete! Restart your terminal or source your .zshrc for changes to take effect."
open -a iTerm
