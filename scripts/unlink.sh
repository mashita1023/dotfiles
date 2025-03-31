#!/bin/sh

# シンボリックリンクを解除する関数
remove_symlink() {
  if [ -L ~/"$1" ]; then
    echo "Removing symlink: ~/$1"
    rm -f ~/"$1"
  elif [ -e ~/"$1" ]; then
    echo "Warning: ~/$1 exists but is not a symlink"
  else
    echo "Symlink ~/$1 does not exist"
  fi
}

# ディレクトリ内のシンボリックリンクを解除する関数
remove_symlinks_in_dir() {
  if [ -d ~/"$1" ]; then
    echo "Removing symlinks in directory: ~/$1"
    find ~/"$1" -type l -delete
  else
    echo "Directory ~/$1 does not exist"
  fi
}

# 設定スクリプトで作成したシンボリックリンクを解除
remove_symlink .config/fish/config.fish
remove_symlink .config/fish_plugins
remove_symlink Brewfile
remove_symlink .config/git/ignore
remove_symlink .config/git/config
remove_symlink .config/tmux/tmux.conf
remove_symlink .emacs.d

# fish functions ディレクトリのシンボリックリンクを解除
remove_symlinks_in_dir .config/fish/functions

echo "All symbolic links have been removed"
