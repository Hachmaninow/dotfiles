#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/projects/dotfiles                    # dotfiles directory
files="zshrc vimrc tmux.conf"    # list of files/folders to symlink in homedir

##########

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -f -s $dir/$file ~/.$file
done

##########

# copy other files

# vim color-scheme
mkdir -p ~/.vim/colors
cp -f $dir/railscasts.vim ~/.vim/colors

# start zsh as any user using oh-my-zsh configuration from hman
cp -f $dir/start-zsh.sh ~
