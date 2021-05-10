# fish, curl, brew, git前提

function startup_shell

  git config --global user.name "Toshichika Mashimo"
  git config --global user.email "mashita1023@gmail.com"

  git config --global core.editor 'emacs -nw'
  git config --global core.ignorecase fasle
  git config --global core.quotepath false
  git config --global core.autocrlf false
  git config --global color.ui true
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto
  git config --global status.showuntrackedfiles all
  git config --global merge.conflictStyle diff3
  git config --global pull.ff only
  git config --global push.default simple
  git conifg --global credential.hellper 'cache --timeout=86400'

  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

  ## brew
  brew bundle install --global

  ## nvm
  fisher install jorgebucaran/nvm.fish
  nvm install lts

  ## powerline-style
  fisher install oh-my-fish/theme-agnoster

  ## fzf
  fisher install jethrokuan/fzf

  ## ghq
  go get github.com/x-motemen/ghq
  fisher install decors/fish-ghq

  ## z
  fisher install jethrokuan/z

end
