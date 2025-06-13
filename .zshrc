export PATH=$PATH:/opt/homebrew/bin/
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# VSCode内ではDISABLE_AUTO_TMUX環境変数を設定
if [[ -n "$VSCODE_INJECTION" || "$TERM_PROGRAM" == "vscode" ]]; then
    export DISABLE_AUTO_TMUX=1
else
    # VSCode以外の環境でのみfishを起動
    fish
fi
