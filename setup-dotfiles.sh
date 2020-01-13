#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -sv $DIR/zshrc ~/.zshrc
ln -sv $DIR/vimrc ~/.vimrc
ln -sv $DIR/spacemacs ~/.spacemacs

