# Packages that mise's brew backend can't install.

# mise can't run the postflight symlink step. Skip the docker CLI symlinks in
# /usr/local/bin too, since OrbStack owns them and the conflict aborts the install.
cask "docker-desktop", args: { no_binaries: true }

tap "abue-ammar/tinycast"
cask "tinycast"

tap "immanuwell/droast"
brew "droast"
