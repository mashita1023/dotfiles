#!/bin/sh
fish -c "curl -sL git.io/fisher | source && fisher update"
ln -sfn ~/dotfiles/.config/fish/my_functions/* ~/.config/fish/functions/
