#!/bin/bash

DEST_DIR="$HOME/Hyprland-Dots/.themes"
BACKUP_DIR="$DEST_DIR/bak"

if [[ -e "$BACKUP_DIR" ]]; then
  read -rp 'Existing backup found. Delete it? (y/N) ' deleteBackup
  deleteBackup=$(echo "$deleteBackup" | tr '[:upper:]' '[:lower:]')
  if [[ $deleteBackup == 'y' ]]; then
    rm -r "$BACKUP_DIR"
  fi
fi

if [[ (! -e "$BACKUP_DIR") || ("$deleteBackup" == 'y') ]]; then
  read -rp 'Backup existing themes? (Y/n) ' backup
  backup=$(echo "$backup" | tr '[:upper:]' '[:lower:]')
  if [[ "$backup" == 'y' || -z "$backup" ]]; then
    mkdir "$BACKUP_DIR"
    mv "$DEST_DIR"/Colloid* "$BACKUP_DIR"
  else
    rm -r "$DEST_DIR"/Colloid*
  fi
fi

declare -A themes
themes['everforest']='green'
themes['rosepine']='teal'
themes['catppuccin']='purple'
themes['material']=''

for theme in "${!themes[@]}"; do
  args=(-d "$DEST_DIR" --tweaks "$theme" -c standard)
  if [[ -n "${themes[$theme]}" ]]; then
    args+=(-t)
    args+=("${themes[$theme]}")
  fi
  # ./install.sh -d "$DEST_DIR" -t "${themes[$theme]}" --tweaks "$theme" -c standard
  ./install.sh "${args[@]}"
done

find "$DEST_DIR"/Colloid* -maxdepth 0 -type d -exec cp LICENSE {} \;

