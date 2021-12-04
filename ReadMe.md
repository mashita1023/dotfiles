# 構造
```
.
├── .Brewfile
├── .bashrc
├── .editorconfig
├── .emacs.d
│   ├── #custom.el#
│   ├── ac-comphist.dat
│   ├── auto-save-list
│   ├── custom.el
│   ├── elpa
│   ├── init.el
│   └── network-security.data
├── .git
│   ├── COMMIT_EDITMSG
│   ├── HEAD
│   ├── branches
│   ├── config
│   ├── description
│   ├── hooks
│   ├── index
│   ├── info
│   ├── logs
│   ├── objects
│   └── refs
├── .gitconfig
├── .tmux.conf
├── ReadMe.md
├── fish
│   ├── completions
│   ├── conf.d
│   ├── config.fish
│   ├── fish_plugins
│   ├── fish_variables
│   └── functions
└── startup.fish
```

# startup
`startup.fish`は動作確認を全く行いないメモ状態なのでそれっぽいコマンドを打ってください
```fish
$ brew bundle install
$ source ./startup.fish
$ startup
```

# fishめも
completions/ 	補完についてのディレクトリ
functions/ 	関数についてのディレクトリ
