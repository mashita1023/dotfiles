#!/bin/sh

unlink_private_file () {
  target="$1"
  if [ -n "$2" ]; then
    symbol="$2"
  else
    symbol="$1"
  fi

  if [ -L ~/dotfiles/$symbol ]; then
    rm -f ~/dotfiles/$symbol
    echo "Unlinked $1"
  fi
}

unlink_private_dir () {
  target="$1"
  if [ -n "$2" ]; then
    symbol="$2"
  else
    symbol="$1"
  fi

  if [ -L ~/dotfiles/$symbol ]; then
    rm -f ~/dotfiles/$symbol
    echo "Unlinked $1"
  fi
}

unlink_direct_dir () {
  target="$1"
  if [ -n "$2" ]; then
    symbol="$2"
  else
    symbol="$1"
  fi

  if [ -L ~/$symbol ]; then
    rm -f ~/$symbol
    echo "Unlinked $1"
  fi
}

# remove direct symbolic links
unlink_direct_dir .ssh
unlink_direct_dir tunnel
unlink_private_file .config/fish/environments.fish
unlink_private_dir .config/fish/my_functions/ .config/fish/private_functions

# remove function symbolic links
for link in ~/.config/fish/functions/*; do
  if [ -L "$link" ]; then
    if echo "$link" | grep -q "private_dotfiles"; then
      rm -f "$link"
      echo "Unlinked $(basename "$link")"
    fi
  fi
done

# remove fish configuration symbolic links
for link in ~/.config/fish/*; do
  if [ -L "$link" ]; then
    if echo "$link" | grep -q "private_dotfiles"; then
      rm -f "$link"
      echo "Unlinked $(basename "$link")"
    fi
  fi
done

echo "All private symbolic links have been removed."
