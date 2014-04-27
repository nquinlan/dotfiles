#!/bin/sh

if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
  brew doctor
fi

curl https://raw.github.com/creationix/nvm/v0.4.0/install.sh | sh


brew install

brew tap phinze/cask
brew install brew-cask

brew install terminal-notifier
