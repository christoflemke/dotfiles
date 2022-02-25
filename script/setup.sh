#!/bin/bash
set -e

DOTFILES_DIR=$(cd $(dirname "$0")/.. && pwd)

echo "apt-install"
$DOTFILES_DIR/script/apt-install.sh

sync-folder() {
    local source_dir=${1?'missing source_dir'}
    local target_dir=${2?'missing target_dir'}
    mkdir -p "$target_dir"
    for dotfile in ${source_dir}/.*; do
        target="${target_dir}/$(basename $dotfile)"
        [ -L "$target" ] && rm "$target"
        [ -f "$dotfile" ] && ln -s "$dotfile" "$target"
    done    
}

sync-folder "$DOTFILES_DIR"/homefs ~/
