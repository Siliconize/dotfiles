#!/bin/bash

# Run mpstat and get per-CPU usage percentages
usages=$(mpstat -P ALL 1 1 | awk '
    /^Linux/ { next }    # Skip system information line
    /^$/ { next }        # Skip empty lines
    /CPU/ && /%idle/ {
        data_block = 1
        # Find the column indices for "CPU" and "%idle"
        for (i = 1; i <= NF; i++) {
            if ($i == "CPU") cpu_col = i
            if ($i == "%idle") idle_col = i
        }
        # Reset the usage array for the new data block
        delete usage_arr
        next
    }
    data_block && $cpu_col ~ /^[0-9]+$/ {
        # Collect usage percentages for each CPU
        idle_val = $idle_col + 0    # Convert to number
        usage = 100 - idle_val
        usage_arr[$cpu_col] = usage
        next
    }
    END {
        # Output usage percentages from the last data block
        for (i in usage_arr) {
            printf "%.2f ", usage_arr[i]
        }
    }
')

# Read the usages into an array
read -a usage_array <<< "$usages"

# Define gruvbox colors for different usage levels
declare -A colors=(
    [green]="#89b482"
    [yellow]="#fabd2f"
    [orange]="#fe8019"
    [red]="#fb4934"
)

# Function to determine the color based on usage
get_color() {
    local usage=$1
    if (( $(echo "$usage < 25" | bc -l) )); then
        echo "${colors[green]}"
    elif (( $(echo "$usage < 50" | bc -l) )); then
        echo "${colors[yellow]}"
    elif (( $(echo "$usage < 75" | bc -l) )); then
        echo "${colors[orange]}"
    else
        echo "${colors[red]}"
    fi
}

# Generate the pango markup output
output=""
for usage in "${usage_array[@]}"; do
    color=$(get_color "$usage")
    output+="<span foreground=\"$color\">■</span>"
done

# Print the final output
echo -e "$output"

