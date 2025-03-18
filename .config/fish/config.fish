if status is-interactive

# brew
eval (/opt/homebrew/bin/brew shellenv)

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
#set --export --prepend PATH "/Users/toshichika-mashimo/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

set -U fish_user_paths /Users/toshichika-mashimo/.asdf/shims/ruby $fish_user_paths

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# direnv
eval (direnv hook fish)

# tmux
   if test -z $TMUX
       tmux new-session -d -s 'work'
       tmux new-session -d -s 'mine'
       tmux new-session -d -s 'cfo'
       tmux attach -t work

   ### セッション立ち上げ時以外にセッションを選択する場面がないため削除
#   else
#       set -ul TMUX_LIST $TMUX_LIST (tmux list-sessions)
#       set -ul TMUX_LIST $TMUX_LIST[-1..1]
#       set TMUX_LIST $TMUX_LIST "Create New Session: "

#       for val in $TMUX_LIST
#            set TMUX_LIST_ID $TMUX_LIST_ID (echo $val | cut -d: -f1)
#       end
#       set -ul TMUX_SELECT_ID (printf '%s\n' $TMUX_LIST_ID | fzf)
#       echo $TMUX_SELECT_ID

#       if test "$TMUX_SELECT_ID" = "Create New Session"
#            tmux new-session -d
#            tmux attach
#       else
#            tmux switch-client -t $TMUX_SELECT_ID
#       end
   end
#end
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

#function ghq_fzf_repo -d 'Repository search'
#  ghq list --full-path | fzf --reverse --height=100% | read select
#  [ -n "$select" ]; and cd "$select"
#  echo " $select "
#  commandline -f repaint
#end

#function fish_user_key_bindings
#  bind \cc ghq_fzf_repo
#end

# poetry
#set -x PATH $PATH:$HOME/.local/bin

# rancher_desktop no omajinai
#function rancher_lima
#  /bin/bash -c "$(curl -fsSL https://gist.githubusercontent.com/mackankowski/be575ec0b81fd8ba3a948d3e84410adc/raw/979b09ab2cc6225ddee1aedaf9e893bb839a715a/script.sh)"
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish
