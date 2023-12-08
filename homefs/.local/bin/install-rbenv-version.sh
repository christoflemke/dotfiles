#!/bin/bash

set -e

VERSION=${1?'missing version'}

wget -O "/tmp/${VERSION}" "https://raw.githubusercontent.com/rbenv/ruby-build/master/share/ruby-build/${VERSION}"
sudo mv "/tmp/${VERSION}" "/usr/share/ruby-build/${VERSION}"
rbenv install "${VERSION}"
