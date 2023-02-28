#!/bin/bash

declare -A PACKAGES
INSTALL_LIST=""

PACKAGES[curl]=curl
PACKAGES[jq]=jq
PACKAGES[gh]=gh
PACKAGES[emacs]=emacs-nox

if [ -z "$CODESPACES" ]; then
  PACKAGES[rbenv]=rbenv
  PACKAGES[nmap]=nmap
  PACKAGES[pass]=pass
fi

if [ ! -f /etc/apt/sources.list.d/github-cli.list ]; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
fi


for executable_name in ${!PACKAGES[@]}; do
    package_name="${PACKAGES[$executable_name]}"
    [ -z "$(which $executable_name)" ] && INSTALL_LIST="$INSTALL_LIST $package_name"
done

if [ -n "$INSTALL_LIST" ]; then
    sudo apt-get update
    sudo apt-get install -y $INSTALL_LIST
fi
