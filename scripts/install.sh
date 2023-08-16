#!/bin/sh

if [ $(uname) == "Darwin" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  /bin/bash -c ". ~/dotfiles/symbolic.sh"
  # test code
  echo "$(ls -l)"
  brew bundle install --global
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
  fisher update
else
  echo "exit $(uname)"
  exit 0
fi
