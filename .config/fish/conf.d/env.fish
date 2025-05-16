# 注意
## 1. conf.d内のアルファベット順に呼び出しされる
## 2. config.fish が呼び出される

# brew
fish_add_path /usr/bin
fish_add_path /usr/local/bin
fish_add_path /bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin

# mise
mise activate fish | source
fish_add_path $HOME/.local/share/mise/shims

# asdf
# fish_add_path $HOME/.asdf/shims

# aqua
set -gx AQUA_ROOT_DIR "$(aqua root-dir)"
fish_add_path $AQUA_ROOT_DIR/bi
set -x AQUA_CONFIG_PATH $HOME/dotfiles/aqua.yaml
set -x AQUA_GLOBAL_CONFIG $HOME/dotfiles/aqua.yaml

# lima
set -x DOCKER_HOST unix://$HOME/.lima/docker/sock/docker.sock

# goenv
fish_add_path $(go env GOPATH)/bin

# mysql
fish_add_path "$(brew --prefix mysql@8.0)/bin"
fish_add_path "$(brew --prefix mysql-client@8.0)/bin"

# tmux
set -x TMUX_PLUGIN_MANAGER_PATH $HOME/.config/tmux/plugins/

# read secrets
if test -f $HOME/.config/env/secrets.gpg
   ## OpenAI
end

# ONELOGIN
set -x ONELOGIN_MFA_IP_ADDRESS $(curl -SsL http://checkip.amazonaws.com/)