#!/bin/bash

DOTFILES_DIR=$(cd $(dirname "$0") && pwd)

echo "apt-install"
"$DOTFILES_DIR/script/apt-install.sh"
echo "npm install"
"$DOTFILES_DIR/script/npm-install.sh"
FORCE=${FORCE:-false}
if [ -n "$CODESPACES" ]; then
  FORCE=true
fi
debug() {
  [ -n "$DEBUG" ] && echo $1 >&2
}

sync-folder() {
  local source_dir=${1?'missing source_dir'}
  local target_dir=${2?'missing target_dir'}
  mkdir -p "$target_dir"

  find "$source_dir" -type f | while read dotfile; do
      target="${dotfile/$source_dir/$target_dir}"
      if [ -L "$target" ]; then
          debug "Delete Link: $target"
          rm -f "$target"
      fi
      if [ -f "$target" ] && [ "$FORCE" == true ]; then
          debug "Delete File: $target"
          rm -f "$target"
      fi

      mkdir -p "$(dirname $target)"
      if [ ! -e "$target" ]; then
          debug "linking $dotfile -> $target"
          ln -s "$dotfile" "$target"
      else
          echo "Skipping ${target}" >&2
      fi
  done
}

sync-folder "$DOTFILES_DIR/homefs" ~/
