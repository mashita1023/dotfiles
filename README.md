# startup
```sh
$ ~/dotfiles/install.sh
$ ~/dotfiles/setup.sh
$ ~/dotfiles/symbolic.sh
$ ~/dotfiles/symbolic_fish_functions.sh
$ ~/dotfiles/symbolic_fish.sh
$ aqua i
```

# private repository 周り

```sh
$ gh auth login
# private repository にアクセスできるようにしておく
$ git submodule update --init --recursive
$ ~/dotfiles/symbolic_private.sh
```

# option
## mise
言語などを取りまとめています
```sh
$ ~/dotfiles/mise.sh
```

# コマンドで手動で設定するもの
- gh
- fvm
- aws
``` fish
$ gh auth login

```

# Docker 周り
lima で動いています。
macの場合buildxが必要なので以下を行うこと

``` fish
$ brew install docker-buildx
$ mkdir -p ~/.docker/cli-plugins
$ ln -sfn $(which docker-buildx) ~/.docker/cli-plugins/docker-buildx
$ docker buildx version
```

# language server

``` fish
$ go install golang.org/x/tools/gopls@latest
```

# caskで手動でいろいろするもの
- bitwarden
- gifity
- inkdrop
- raindropio
- raycast
  - Advancedから`.rayconfig`をimportする
- iterm2
  - https://qiita.com/reoring/items/a0f3d6186efd11c87f1b

# その他頑張るやつ
## Mac
- IMEの設定
- キーボード、CapsLock周り
- RayCastを初期に
