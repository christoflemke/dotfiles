#!/bin/bash
set -e

DOTFILES_DIR=$(cd $(dirname "$0")/.. && pwd)

echo "apt-install"
$DOTFILES_DIR/script/apt-install.sh

echo "linking files"
for dotfile in $(find ${DOTFILES_DIR}/homefs -type f); do
    echo "linking ${dotfile}"
    target="${HOME}/${dotfile#"${DOTFILES_DIR}/homefs/"}"
    mkdir -p "$(dirname $target)"
    [ -L "$target" ] && rm "$target"
    [ -f "$dotfile" ] && ln -s "$dotfile" "$target"
done 