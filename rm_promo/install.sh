#!/bin/bash

set -euo pipefail

CASTOM_PATH="$HOME"

read -p "Use default installation path ($CASTOM_PATH) ? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Write the full path to the directory:"
    read
    CASTOM_PATH="$REPLY"
    if [ ! -d "$CASTOM_PATH" ]; then
        echo "Such directory does not exist."
        exit 1
    fi
fi

SOURCE_DIR="$PWD"
TARGET_DIR="$CASTOM_PATH/rm_promo"
PROMO_DATA="$TARGET_DIR/data/promo.txt"

if ! grep -q "rm_promo.sh" "$HOME/.zshrc"; then
    cat << EOF >> "$HOME/.zshrc"
# RM Promo
$TARGET_DIR/rm_promo.sh
EOF
fi

if [ ! -d "$TARGET_DIR" ]; then
    cp -r "$SOURCE_DIR" "$TARGET_DIR"
fi

if [ ! -f "$PROMO_DATA" ]; then
    touch "$PROMO_DATA"
    echo "Created empty promo.txt. Add files to delete."
fi

cd "$TARGET_DIR"

echo "The following promos will be deleted now:"
while read -r promo; do
    echo -e "- \033[1;31m$promo\033[0m"
done < "$PROMO_DATA"
echo "If you need to change this list, edit the file $PROMO_DATA"

read -p "Do you want to change the list now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    nano "$PROMO_DATA"
fi

if [ "$TARGET_DIR" != "$SOURCE_DIR" ]; then
    read -p "Delete $SOURCE_DIR? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$SOURCE_DIR"
        echo -e "\033[1;31m\nThe installation directory has been deleted.\033[0m"
    fi
fi

if [ -f "$TARGET_DIR/install.sh" ]; then
    read -p "Delete $TARGET_DIR/install.sh ? (y/n): " -n 1 -r
    [[ $REPLY =~ ^[Yy]$ ]] || exit 0
    rm -rf "$TARGET_DIR/install.sh"
    echo -e "\033[1;31m\nThe installation file has been deleted.\033[0m"
fi

./rm_promo.sh
