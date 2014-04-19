#!/bin/bash

# Get things running!
for file in ~/.dotfiles/{zshrc,vimrc,gitconfig}; do
	ln -fs "~/.dotfiles/$file" "~/.$file"
done
