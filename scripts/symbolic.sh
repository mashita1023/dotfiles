#!/bin/sh

file_exist () {
  if [ -e $1 ]; then
    rm ~/$1
  fi
}

dir_exist () {
  if [ -n $1 ]; then
    rm -rf ~/$1
  fi
}

create_dir () {
  if [ ! -n $1]; then
    mkdir -p ~/$1
  fi
}

symbolic_file () {
  echo $1
  target=$1
  if [ -n $2 ]; then
    symbol=$2
  else
    symbol=$1
  fi

  if [ -e $target ]; then
    file_exist $symbol
    ln -sfn ~/dotfiles/$target/ ~/$symbol
    echo "$1 success"
  else
    echo "$1 failed"
  fi
}

symbolic_dir () {
  echo $1
  target=$1
  if [ -n $2 ]; then
    symbol=$2
  else
    symbol=$1
  fi

  if [ -d $target ]; then
    ln -sfn ~/dotfiles/$target ~/$symbol
    echo "$1 success"
  else
    echo "$1 failed"
  fi
}

# create directory
create_dir .config/git
create_dir .config/fish
create_dir .config/tmux

# create symbolic link
symbolic_file .config/fish/config.fish
symbolic_file .config/fish_plugins
symbolic_file Brewfile
symbolic_file .config/git/ignore
symbolic_file .config/git/config
symbolic_file .config/tmux/tmux.conf
symbolic_dir .leaf.d .emacs.d

ln -sfn ~/dotfiles/.config/fish/my_functions/* ~/.config/fish/functions/

echo "complete symbolic link"
