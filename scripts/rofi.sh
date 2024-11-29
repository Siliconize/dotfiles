#!/bin/bash

# Default directory for the file browser
DEFAULT_DIR="$HOME/Documents"

# Generate menu items
generate_menu() {
    # List programs (drun mode)
    rofi -modi drun -show drun -dump | awk -F '\t' '{print "Program: " $1}'

    # List files and directories
    find "$DEFAULT_DIR" -maxdepth 1 -mindepth 1 \( -type f -printf "File: %f\n" -o -type d -printf "Dir: %f/\n" \)

    # Add a hint for calculations
    echo "Math: Type '=' followed by your calculation"
}

# Handle user selection
handle_selection() {
    local input="$1"

    if [[ "$input" == Program:\ * ]]; then
        # Launch a program
        program="${input#Program: }"
        nohup "$program" > /dev/null 2>&1 &
    elif [[ "$input" == File:\ * ]]; then
        # Open a file
        file="${input#File: }"
        xdg-open "$DEFAULT_DIR/$file" &
    elif [[ "$input" == Dir:\ * ]]; then
        # Open a directory
        dir="${input#Dir: }"
        xdg-open "$DEFAULT_DIR/$dir" &
    elif [[ "$input" == "="* ]]; then
        # Perform a calculation
        result=$(qalculate-gtk --non-interactive <<< "${input#=}" 2>/dev/null)
        echo -n "$result" | xclip -selection clipboard
        echo "$input = $result" | rofi -dmenu -p "Result"
    fi
}

# Main script execution
main() {
    # Generate menu and show it in Rofi
    selection=$(generate_menu | rofi -dmenu -p "Run/Browse/Calc")

    # Handle the selected item
    if [[ -n "$selection" ]]; then
        handle_selection "$selection"
    fi
}

main

