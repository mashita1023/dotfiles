#!/bin/sh
# プラグインのインストール (miseでは不要な場合が多いが互換性のために)
mise plugins install dart
mise plugins install golang
mise plugins install python
mise plugins install nodejs
mise plugins install ruby

# 最新バージョンのインストール
mise install dart@latest
mise install golang@latest
mise install python@latest
mise install nodejs@latest
mise install ruby@latest

# 特定の古いバージョンのインストール
mise install python@2.7.18
mise install nodejs@8.1.3

# グローバル設定
mise use -g dart@latest
mise use -g golang@latest
mise use -g python@latest
mise use -g nodejs@latest
mise use -g ruby@latest
