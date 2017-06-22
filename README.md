# dotfiles

Setup directories:
`mkdir ~/tools`
`mkdir ~/projects`

Install oh-my-zsh:
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

Clone dotfiles:
`git clone git@github.com:Hachmaninow/dotfiles.git ~/projects/dotfiles`

Clone antigen:
`git clone git@github.com:zsh-users/antigen.git ~/tools/antigen`

Clone vundle:
`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

Create symlinks:
`~/projects/dotfiles/setup-dotfiles.sh`

Setup vim plugins in vim:
`:VundleInstall`

Font installation for powerline see:
https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation

