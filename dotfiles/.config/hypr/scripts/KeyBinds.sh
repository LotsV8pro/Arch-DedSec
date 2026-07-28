#!/usr/bin/env bash
# searchable enabled keybinds using rofi (supports bindd descriptions)

# kill yad to not interfere with this binds
pkill yad || true

# check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# define the config files
keybinds_lua="$HOME/.config/hypr/configs/Keybinds.lua"
user_keybinds_lua="$HOME/.config/hypr/UserConfigs/UserKeybinds.lua"
laptop_lua="$HOME/.config/hypr/UserConfigs/Laptops.lua"
rofi_theme="$HOME/.config/rofi/config-keybinds.rasi"
msg='☣️ NOTE ☣️: Clicking with Mouse or Pressing ENTER will have NO function'

# collect raw bind lines from available files (prefer .lua)
files=()
[[ -f "$keybinds_lua" ]] && files+=("$keybinds_lua")
[[ -f "$user_keybinds_lua" ]] && files+=("$user_keybinds_lua")
[[ -f "$laptop_lua" ]] && files+=("$laptop_lua")

# Parse binds using the python script for speed
# The last argument must be the user config for override logic to work correctly
display_keybinds=$("$HOME/.config/hypr/scripts/keybinds_parser.py" "${files[@]}")

# Check for suggestions file created by python script
if [[ -f "/tmp/hypr_keybind_suggestions_file" ]]; then
  suggestions_file=$(cat "/tmp/hypr_keybind_suggestions_file")
  rm "/tmp/hypr_keybind_suggestions_file"
  if [[ -n "$suggestions_file" && -f "$suggestions_file" ]]; then
     count=$(wc -l < "$suggestions_file")
     msg="$msg | Overrides missing unbind: $count (suggestions: $suggestions_file)"
  fi
fi

# use rofi to display the keybinds
printf '%s\n' "$display_keybinds" | rofi -dmenu -i -config "$rofi_theme" -mesg "$msg"
