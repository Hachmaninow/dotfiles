# dotfiles

## Preparation

Setup directories:
`mkdir ~/tools`
`mkdir ~/code`

## Installation

Install oh-my-zsh:
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

Clone dotfiles:
`git clone git@github.com:Hachmaninow/dotfiles.git ~/code/dotfiles`

Clone antigen (zsh plugin manager):
`git clone git@github.com:zsh-users/antigen.git ~/tools/antigen`

Clone vundle (vim package manager):
`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

Create symlinks:
`~/projects/dotfiles/setup-dotfiles.sh`

Setup vim plugins in vim:
`:VundleInstall`

## Tools

ag https://github.com/ggreer/the_silver_searcher
fd https://github.com/sharkdp/fd
jq
httpie
broot https://github.com/Canop/broot
mr http://myrepos.branchable.com/  

## Fonts etc.

Font installation for powerline see:
https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation

