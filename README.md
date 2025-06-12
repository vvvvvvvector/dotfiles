Install Apple's CLI tools, which are prerequesties for Git and Homebrew

```sh
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

## Homebrew

Install Homebrew followed by software listed in the Brewfile

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

In order to install packages pass in the Brewfile location

```sh
brew bundle --file ~/Github/dotfiles/brew/Brewfile
```

In order to bundle installed packages

```sh
brew bundle dump
```
## What is XDG configuration Path?

```
$XDG_CONFIG_HOME = $HOME/.config/[app]/config
```
