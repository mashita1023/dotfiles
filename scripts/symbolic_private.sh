#!/bin/sh

symbolic_private_file () {
  target=$1
  if [ -n $2 ]; then
    symbol=$2
  else
    symbol=$1
  fi

  if [ -e $target ]; then
    ln -sfn ~/private_dotfiles/$target/ ~/dotfiles/$symbol
    echo "$1 success"
  else
    echo "$1 failed"
  fi
}

symbolic_private_dir () {
  target=$1
  if [ -n $2 ]; then
    symbol=$2
  else
    symbol=$1
  fi

  if [ -d $target ]; then
    ln -sfn ~/private_dotfiles/$target ~/dotfiles/$symbol
    echo "$1 success"
  else
    echo "$1 failed"
  fi
}

symbolic_direct_dir () {
  target=$1
  if [ -n $2 ]; then
    symbol=$2
  else
    symbol=$1
  fi

  if [ -d $target ]; then
    ln -sfn ~/private_dotfiles/$target ~/$symbol
    echo "$1 success"
  else
    echo "$1 failed"
  fi
}

# create submodule symbolic link
symbolic_direct_dir .ssh
symbolic_direct_dir tunnel
symbolic_private_file .config/fish/environments.fish
symbolic_private_dir .config/fish/my_functions/ .config/fish/private_functions

ln -sfn ~/dotfiles/private_dotfiles/fish/my_functions/* ~/.config/fish/functions/
ln -sfn ~/dotfiles/private_dotfiles/fish/* ~/.config/fish/
