#!/bin/bash

DOTFILES_DIR=$(cd $(dirname "$0") && pwd)

echo "apt-install"
$DOTFILES_DIR/script/apt-install.sh

debug() {
  [ -n "$DEBUG" ] && echo $1 >&2
}

sync-folder() {
  local source_dir=${1?'missing source_dir'}
  local target_dir=${2?'missing target_dir'}
  mkdir -p "$target_dir"
  for dotfile in $(find "$source_dir"); do
    target="${dotfile/$source_dir/$target_dir}"
    if [ -L "$target" ]; then
      debug "Delete link: $target"
      rm "$target"
    fi
    if [ -f "$dotfile" ]; then
      debug "linking $dotfile -> $target"
      ln -s "$dotfile" "$target"
    elif [ -d "$target" ]; then
      debug "Skip directory $target"
    else
      echo "Skipping ${target}" >&2
    fi
  done
}

sync-folder "$DOTFILES_DIR/homefs" ~/
