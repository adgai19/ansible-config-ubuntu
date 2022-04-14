#!/bin/bash
set -e

# Paths
DOTFILES_DIR="$HOME/.dotfiles"
if ! [ -x "$(command -v ansible)" ]; then
  sudo pip install ansible
fi

if ! [[ -d "$DOTFILES_DIR" ]]; then
  git clone "git@github.com:adgai19/ansible-config-ubuntu.git" "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull
fi

if ! [ -x "$(command -v dotfiles.sh)" ]; then
  ln -s "$DOTFILES_DIR/bin/dotfiles.sh" "$HOME/.local/bin"
fi
cd "$DOTFILES_DIR"

ansible-galaxy install -r requirements.yml

ansible-playbook --diff "$DOTFILES_DIR/main.yml"
