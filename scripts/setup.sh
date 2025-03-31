#!/bin/bash

# OSの種類を検出
OS="$(uname -s)"

# インストール済みかどうかをチェックする関数
is_installed() {
  command -v "$1" &>/dev/null
}

# 必要なパッケージをインストールする関数
install_packages() {
  echo "=== インストールを開始します ==="
  
  case "$OS" in
    # macOS
    Darwin)
      # Homebrewがインストールされていなければインストール
      if ! is_installed brew; then
        echo "Homebrewをインストールしています..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      
      # Brewfileがあれば使用
      if [ -f ~/dotfiles/Brewfile ]; then
        echo "Brewfileからパッケージをインストールしています..."
        brew bundle --file=~/dotfiles/Brewfile
      else
        # 基本的なツールをインストール
        echo "基本的なパッケージをインストールしています..."
        brew install git tmux fish 
      fi
      ;;
      
    # Linux (Ubuntu/Debian系)
    Linux)
      if [ -f /etc/debian_version ]; then
        echo "apt パッケージをインストールしています..."
        sudo apt update
        sudo apt install -y git tmux fish curl wget zsh emacs
      # Fedora/RedHat系
      elif [ -f /etc/redhat-release ]; then
        echo "dnf パッケージをインストールしています..."
        sudo dnf install -y git tmux fish curl wget zsh emacs
      # Arch Linux
      elif [ -f /etc/arch-release ]; then
        echo "pacman パッケージをインストールしています..."
        sudo pacman -Syu git tmux fish curl wget zsh emacs
      else
        echo "未サポートのLinuxディストリビューションです"
      fi
      ;;
      
    *)
      echo "未サポートのOSです: $OS"
      exit 1
      ;;
  esac
}

# 追加のセットアップ
additional_setup() {
  # aquaのインストール
  if ! command -v aqua &> /dev/null; then
    echo "aquaをインストールしています..."
    curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.0.2/aqua-installer | bash
    echo 'export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"' >> ~/.bashrc
    # fishシェル用
    echo 'set -x PATH ${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin $PATH' >> ~/.config/fish/config.fish
  fi
  # fishをzshから起動
  if is_installed fish && ! grep -q fish /etc/shells; then
    echo "fishをデフォルトシェルに設定しています..."
    echo 'fish' >> ~/.bashrc
  fi
}

# メイン処理
main() {
  install_packages
  additional_setup
  
  echo "=== インストールが完了しました ==="
  echo "dotfilesのセットアップを続けるには setup.sh を実行してください"
}

# スクリプトの実行
main
