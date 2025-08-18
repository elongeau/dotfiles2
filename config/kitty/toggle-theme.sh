#!/bin/bash
THEME_DIR="$HOME/.config/kitty"
if [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == "Dark" ]]; then
  cp "$THEME_DIR/rose-pine.conf" "$THEME_DIR/current-theme.conf"
else
  cp "$THEME_DIR/rose-pine-dawn.conf" "$THEME_DIR/current-theme.conf"
fi
kitty @ set-colors --all "$THEME_DIR/current-theme.conf"
