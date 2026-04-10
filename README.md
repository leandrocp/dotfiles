## dotfiles

### Bootstrap

1. Install [brew](https://brew.sh)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install pre-requisites

```
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install git just
```

3. Bootstrap

```sh
git clone git@github.com:leandrocp/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
just install
```
