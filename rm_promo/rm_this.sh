#!/bin/bash

set -euo pipefail

DEL_DIR="$PWD"

if [ -d "$DEL_DIR" ]; then
    read -p "Delete $DEL_DIR ? (y/n): " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$DEL_DIR"
        echo -e "\033[1;31m\nThe rm_promo has been deleted.\033[0m"
    fi
fi

read -p "Edit file .zshrc it is necessary to remove the lines with the launch of the cleaning file ( a file with the old configuration will be created .zshrc.bak )  ? (y/n): " -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] || exit 0
sed -i.bak '/^# RM Promo$/,/^\$HOME\/rm_promo\/rm_promo\.sh$/d' ~/.zshrc

echo ".zshrc has been edited and has been new file .zshrc.bak with old settings, it is advisable to delete it only after rebooting the system and terminal"
