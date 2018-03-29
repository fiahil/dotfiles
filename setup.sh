#!/bin/bash

# Install RVM
# curl -L https://get.rvm.io | bash -s stable --autolibs=enabled --ruby

if [[ $(uname) == 'Darwin' ]]; then
  # MacOS

  # Accept x-code license stuff
  xcode-select --install

  # Install Homebrew
  sudo chmod g+rwx /usr/local/
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Some utilities
  brew update && brew upgrade
  brew install htop-osx tree wget the_silver_searcher
  brew install watch cmake automake autoconf freetype

  # Install htop
  sudo htop

  # RCM
  brew tap thoughtbot/formulae
  brew install rcm lua

  # Cask
  brew tap caskroom/cask
  brew install brew-cask
  brew cask install --appdir="/Applications" macvim
  brew cask install --appdir="/Applications" google-chrome
  brew cask install --appdir="/Applications" vlc
  brew cask install --appdir="/Applications" iterm2
  brew cask install --appdir="/Applications" spotify
  # brew cask install --appdir="/Applications" flycut
  brew cask install --appdir="/Applications" the-unarchiver
  # brew cask install --appdir="/Applications" rescuetime
  # brew cask install --appdir="/Applications" mjolnir
  # brew cask install --appdir="/Applications" dash
  # brew cask install --appdir="/Applications" seil
  # brew cask install --appdir="/Applications" slack

  # Install Mjolnir
  #  echo 'rocks_servers = { "http://rocks.moonscript.org" }' >> \
  #    /usr/local/etc/luarocks52/config-5.2.lua
  #  luarocks install mjolnir.hotkey
  #  luarocks install mjolnir.application
  #  luarocks install mjolnir.fnutils
  #  luarocks install mjolnir.screen
  #  luarocks install mjolnir.bg.grid

else
  # Debian/Ubuntu

  sudo apt-get update && sudo apt-get upgrade -y
  sudo apt-get install -y silversearcher-ag wget htop tree vim

  # Install RCM
  wget https://thoughtbot.github.io/rcm/debs/rcm_1.3.0-1_all.deb
  sha=$(sha256sum rcm_1.3.0-1_all.deb | cut -f1 -d' ')
  [ "$sha" = "2e95bbc23da4a0b995ec4757e0920197f4c92357214a65fedaf24274cda6806d" ] && \
    sudo dpkg -i rcm_1.3.0-1_all.deb
fi

# RCUP to update configurations
pwd=$(pwd)
export RCRC="$pwd/rcm/rcrc"
rcup -v

# Install custom Fonts
bash ./fonts/install.sh

# installing Oh My Zsh
bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

