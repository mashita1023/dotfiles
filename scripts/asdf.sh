#!/bin/sh
asdf plugin-add dart
asdf plugin-add golang
asdf plugin-add python
asdf plugin-add nodejs
asdf plugin add ruby

asdf install dart latest
asdf install golang latest
asdf install python latest
asdf install nodejs latest
asdf install ruby latest

# nodejs 8
asdf install python 2.7.18
asdf global python 2.7.18
asdf install nodejs 8.1.3

# global
asdf global dart latest
asdf global golang latest
asdf global pytohn latest
asdf global nodejs latest
asdf global ruby latest
