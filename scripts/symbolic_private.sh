#!/bin/sh

symbolic_direct_file () {
  target="$1"
  if [ -n "$2" ]; then
    symbol="$2"
  else
    symbol="$1"
  fi

  if [ -e "$HOME/dotfiles/private_dotfiles/$target" ]; then
    ln -sfn ~/dotfiles/private_dotfiles/"$target"/ ~/"$symbol"
    echo "$1 success"
  else
    echo "$1 failed"
  fi
}

symbolic_private_dir () {
  target="$1"
  if [ -n "$2" ]; then
    symbol="$2"
  else
    symbol="$1"
  fi

  if [ -d "$HOME/dotfiles/private_dotfiles/$target" ]; then
    ln -sfn ~/dotfiles/private_dotfiles/"$target" ~/dotfiles/"$symbol"
    echo "$1 success"
  else
    echo "$1 failed"
  fi
}

symbolic_direct_dir () {
  target="$1"
  if [ -n "$2" ]; then
    symbol="$2"
  else
    symbol="$1"
  fi

  if [ -d "$HOME/dotfiles/private_dotfiles/$target" ]; then
    ln -sfn ~/dotfiles/private_dotfiles/"$target" ~/"$symbol"
    echo "$1 success"
  else
    echo "$1 failed"
  fi
}

check_ssh_permissions() {
    has_error=0
    ssh_dir="$HOME/.ssh"

    # .sshディレクトリの確認
    if [ ! -d "$ssh_dir" ]; then
        return 0
    fi

    # OSによってstatコマンドの形式を変更
    case "$(uname)" in
        "Darwin") stat_format="-f %Lp" ;;
        *)        stat_format="-c %a" ;;
    esac

    # find の結果を処理
    find "$ssh_dir" -type f | while read -r file; do
        perms=$(stat $stat_format "$file")
        filename=$(basename "$file")
        
        if [ "$perms" = "600" ]; then
            echo "Error: File $filename has incorrect permissions (600)"
            echo "Current permissions: $perms"
            echo "Expected permissions for private key: 400"
            has_error=1
        fi
    done

    return $has_error
}
# check permission 600 file
if check_ssh_permissions; then
    echo "All SSH file permissions are correct."
    rm -rf ~/.ssh
else
    echo "SSH permission errors found."
    exit 1
fi

# create submodule symbolic link
symbolic_direct_dir .ssh
symbolic_direct_dir tunnel
symbolic_direct_file .config/fish/environments.fish

ln -sfn ~/dotfiles/private_dotfiles/fish/my_functions/* ~/.config/fish/functions/
ln -sfn ~/dotfiles/private_dotfiles/fish/* ~/.config/fish/
