# Change Emoji Shortcut to Command-Option-E
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Special Characters..." "@~e"

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set New Finder Windows to Display ~
defaults write com.apple.finder NewWindowTargetPath "file://`echo ~`"
defaults write com.apple.finder NewWindowTarget PfHm

# Allow Airdrop Over All Interfaces
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Show Extensions
defaults write -g AppleShowAllExtensions -bool TRUE

# Run the screensaver if we're in the top-left hot corner.
defaults write com.apple.dock wvous-tl-corner -int 5
defaults write com.apple.dock wvous-tl-modifier -int 0

# Restart Finder, so changes may take effect
killall Finder
killall -KILL Dock
