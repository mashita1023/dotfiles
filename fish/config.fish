# tmux
command tmux

# abbr
abbr -a e emacs -nw
abbr -a eb emacs --batch -f batch-byte-compile ~/dotfiles/.leaf.d/init.el
abbr -a dc docker-compose

abbr -a g git
abbr -a gs git status
abbr -a ga git add -A
abbr -a gco git commit -m ""
abbr -a gb git branch
abbr -a gps git push
abbr -a gpl git pull
abbr -a gck git checkout
abbr -a gdf git diff
abbr -a gsw git switch
abbr -a gsc git switch -c
abbr -a grb git rebase

abbr -a ls ls -alF
abbr -a l ls -CF

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

# goenv
    set -x GOENV_ROOT "$HOME/.anyenv/envs/goenv"
    set -x PATH $PATH "$GOENV_ROOT/bin"
    set -gx PATH "$GEONV_ROOT/shims" $PATH
    set -x GOROOT (goenv prefix)
    set -x GOPATH $HOME/go/(goenv versions --bare)
    eval (goenv init - | source)

    set -x GOPRIVATE \"github/mashita1023/\"

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)
