#!/bin/bash

# Get things running!
for file in {zshrc,bash_profile,vimrc,gitconfig}; do
	ln -fs ~/.dotfiles/$file ~/.$file
done

ln -fs ~/.dotfiles/bash_profile ~/.bashrc

for file in ~/{todo,.todo} do
	mkdir --parents $file
done

ln -fs ~/.dotfiles/todo ~/todo/todo.cfg
ln -fs ~/.dotfiles/todo ~/.todo/config
