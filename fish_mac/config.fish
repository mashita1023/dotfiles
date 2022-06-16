if status is-interactive
    # Commands to run in interactive sessions can go here

    if test -z $TMUX
       tmux new-session -d -s 'retty'
       tmux new-session -d -s 'nutmeg'
       tmux new-session -d -s 'kslab'
       tmux attach -t retty
    else
        set -ul TMUX_LIST $TMUX_LIST (tmux list-sessions)

        set -ul TMUX_LIST $TMUX_LIST[-1..1]
        set TMUX_LIST $TMUX_LIST "Create New Session:"

        for val in $TMUX_LIST
            set TMUX_LIST_ID $TMUX_LIST_ID (echo $val | cut -d: -f1)
        end

        set -ul TMUX_SELECT_ID (printf '%s\n' $TMUX_LIST_ID | fzf)
        echo $TMUX_SELECT_ID

        if test "$TMUX_SELECT_ID" = "Create New Session"
           tmux new-session -d
           tmux attach
        else
           tmux switch-client -t $TMUX_SELECT_ID
        end
    end

    # local env
    abbr -a e emacs -nw
    abbr -a eb emacs --batch -f batch-byte-compile ~/dotfiles/.leaf.d/init.el
    abbr dc docker compose

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
    abbr -a grb git rebase

    abbr -a ls ls -alF
    abbr -a l ls -CF

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

    # anyenv
    eval "$(anyenv init -)"

#    set -x GOENV_ROOT "$HOME/.anyenv/envs/goenv"
#    set -x PATH $PATH "$GOENV_ROOT/bin"
#    set -gx PATH "$GEONV_ROOT/shims" $PATH
#    set -x GOROOT (goenv prefix)
#    set -x GOPATH $HOME/go/(goenv versions --bare)
#    eval (goenv init - | source)

    set -x GOPRIVATE \"github/mashita1023/\"

    # gh
    eval (gh completion -s fish | source)
end
