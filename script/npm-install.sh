#!/bin/bash

set -e

NODE_VERSION=18

export NVM_DIR=$HOME/.nvm
[ -s $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh

if [ "$(type -t nvm)" != 'function' ]; then
    echo "install nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    source $NVM_DIR/nvm.sh
fi

if [ "$(nvm version $NODE_VERSION)" == 'N/A' ]; then
    echo "Install node version $NODE_VERSION"
    nvm install $NODE_VERSION
fi

if [ -z "$(nvm current | grep v$NODE_VERSION)" ]; then
    echo "Use node version $NODE_VERSION"
    nvm use $NODE_VERSION
fi
