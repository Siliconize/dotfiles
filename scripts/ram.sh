#!/bin/bash

# Get total and available memory in kilobytes
read total_mem available_mem <<< $(awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {print t, a}' /proc/meminfo)

# Calculate used memory and RAM usage percentage
used_mem=$((total_mem - available_mem))
ram_usage=$(echo "scale=2; $used_mem / $total_mem * 100" | bc)

# Define gruvbox colors for different usage levels
declare -A colors=(
    [green]="#89b482"
    [yellow]="#fabd2f"
    [orange]="#fe8019"
    [red]="#fb4934"
)

# Function to determine the color based on RAM usage
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

# Get the color based on RAM usage
color=$(get_color "$ram_usage")

# Generate the pango markup output
output="<span foreground=\"$color\">■</span>"

# Print the final output
echo -e "$output"

