#!/bin/bash

mkdir ~/tools

# install antigen
cd ~/tools && git clone https://github.com/zsh-users/antigen.git

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
