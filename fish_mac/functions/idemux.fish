function idemux
  tmux split -v
  tmux split -h
  tmux split -h
  tmux select-pane -t 1
  tmux new-window
  tmux select-window -t 1
end
