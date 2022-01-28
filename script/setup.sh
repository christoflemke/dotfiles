#!/bin/bash
set -e

DOTFILES_DIR=$(cd $(dirname "$0")/.. && pwd)

echo "apt-install"
$DOTFILES_DIR/script/apt-install.sh


echo "linking files"
for dotfile in ${DOTFILES_DIR}/.*; do
    target="${HOME}/$(basename $dotfile)"
    [ -L "$target" ] && rm "$target"
    [ -f "$dotfile" ] && ln -s "$dotfile" "$target"
done 