# brew
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# tmux
command tmux

# abbr
abbr -a e emacs -nw
abbr -a eb emacs --batch -f batch-byte-compile ~/dotfiles/.leaf.d/init.el
abbr -a dc docker-compose

abbr -a g git
abbr -a gs git status
abbr -a ga git add
abbr -a gap git add --patch
abbr -a gaa git add -A
abbr -a gco git commit -m
abbr -a gb git branch
abbr -a gps git push
abbr -a gpl git pull
abbr -a gck git checkout
abbr -a gdf git diff
abbr -a gsw git switch
abbr -a gs. git checkout .
abbr -a grb git rebase
abbr -a gri git rebase -i HEAD~

abbr -a ls ls -alF
abbr -a ll ls -l
abbr -a la ls -a
abbr -a l ls -CF

abbr -a gcc g++-10
# gcc
set -x PATH $PATH /home/linuxbrew/.linuxbrew/bin/g++-10
# golang
set -x PATH $PATH ~/go/bin

# fzf
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

function ghq_fzf_repo -d 'Repository search'
  ghq list --full-path | fzf --reverse --height=100% | read select
  [ -n "$select" ]; and cd "$select"
  echo " $select "
  commandline -f repaint
end

function fish_user_key_bindings
  bind \cc ghq_fzf_repo
end

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
pyenv init - | source

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

# retty3 ENDPOINTS
set -x ENDPOINT restaurant-service.staging.services.retty3
