#!/usr/bin/env bash

# Close System Settings so it does not overwrite pending changes.
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# Ask for administrator privileges up front.
sudo -v

# Keep the sudo session alive while this script runs.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable automatic capitalization for code and commands.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes so typed hyphens stay unchanged.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable double-space period insertion.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes so quotes stay literal.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable system spell correction.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable inline predictive text suggestions.
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false

# Prefer key repeat over press-and-hold accent picker.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Speed up key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Reduce the delay before key repeat starts.
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Enable tap to click on Apple trackpads.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Enable tap to click for the current host.
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable tap to click globally.
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable natural scrolling.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Remove any delay before password is required.
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Always show file extensions in Finder.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show the Finder status bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Show the Finder path bar.
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders grouped first when sorting by name.
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable the warning shown when changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Avoid creating .DS_Store files on USB volumes.
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show the hidden Library folder in the home directory.
chflags nohidden "$HOME/Library"

# Automatically hide the Dock.
defaults write com.apple.dock autohide -bool true

# Hide recent applications in the Dock.
defaults write com.apple.dock show-recents -bool false

# Save screenshots as PNG files.
defaults write com.apple.screencapture type -string "png"

# Show full URLs in Safari's address bar.
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable the Safari Develop menu.
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Enable Web Inspector in Safari preferences.
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# Enable Web Inspector for Safari web content.
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Restart affected apps so the new settings apply.
for app in "Dock" "Finder" "Safari" "SystemUIServer"; do
  # Ignore failures when an app is not running.
  killall "$app" >/dev/null 2>&1
done

# Print a completion message.
echo "Done. Some changes require logout/restart."
