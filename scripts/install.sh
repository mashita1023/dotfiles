#!/bin/sh

if [ $(uname) = "Darwin" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  git submodule update
  /bin/bash -c ". ~/dotfiles/symbolic.sh"
  /bin/bash -c ". ~/dotfiles/symbolic_private.sh"
  # test code
  echo "$(ls -l)"
  brew bundle install --global
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
  fisher update
elif [ $(uname) = "Linux" ]; then
#  if [ $(uname -m) == "aarch64"]; then
    echo "hoge"
#install ruby
    mkdir -p ~/.cache/Homebrew
    git clone https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew

    cd ~/.cache/Homebrew && \
      wget https://github.com/Homebrew/homebrew-portable-ruby/releases/download/2.6.3/portable-ruby-2.6.3.aarch64_linux.bottle.tar.gz && \
      mkdir -p /home/linuxbrew/.linuxbrew/Library/Homebrew/vendor
    cd /home/linuxbrew/.linuxbrew/Library/Homebrew/vendor && \
      tar -zxvf ~/.cache/Homebrew/portable-ruby-2.6.3.aarch64_linux.bottle.tar.gz
    cd /home/linuxbrew/.linuxbrew/Library/Homebrew/vendor/portable-ruby && \
      ln -sf 2.6.3 current
    export PATH=/home/linuxbrew/.linuxbrew/bin/brew:$PATH

    # install brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#    cd /home/linuxbrew/.linuxbrew && \
#      mkdir /home/linuxbrew/.linuxbrew/bin && \
#      ln -s /home/linuxbrwe/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

 # else
#    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#  fi
  brew bundle install ~/dotfiles/Brewfile
else
  echo "exit $(uname)"
  exit 0
fi

echo "Finish: install.sh"
