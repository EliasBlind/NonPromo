#!/bin/bash

set -euo pipefail

PROMO="$(dirname "$(realpath "$0")")"
cd "$HOME/Desktop"

while read -r file; do
    if [ -e "$file" ]; then
        rm -f "$file"
    fi
done < "$PROMO/data/promo.txt"