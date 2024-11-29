import requests
from datetime import datetime, timedelta

USERNAME = "Siliconize"  # Replace with your GitHub username

# Fetch contributions for the last 10 days
def fetch_contributions():
    today = datetime.now().date()
    last_10_days = [(today - timedelta(days=i)) for i in range(10)]
    contributions = {day: 0 for day in last_10_days}  # Initialize contribution counts

    events_url = f"https://api.github.com/users/{USERNAME}/events"
    response = requests.get(events_url)
    if response.status_code != 200:
        print(f"Error fetching data: {response.status_code}")
        return contributions

    events = response.json()

    # Count events per day
    for event in events:
        created_at = datetime.strptime(event['created_at'], "%Y-%m-%dT%H:%M:%SZ").date()
        if created_at in contributions:
            contributions[created_at] += 1

    return contributions

# Map intensity to green shades
#def intensity_to_color(intensity):
#    green = int(255 * intensity)
#    return f"\033[38;2;0;{green};0m■\033[0m"

#def intensity_to_color(intensity):
#    green = int(255 * intensity)
#    hex_color = f"#{0:02x}{green:02x}{0:02x}"  # RGB to Hex
#    return f"<span foreground='{hex_color}'>■</span>"

def intensity_to_color(intensity):
    # Map intensity to solarized-compatible colors
    if intensity == 0:
        hex_color = "#3c3836"  # No contributions
    elif intensity < 0.25:
        hex_color = "#586e75"  # Low (Solarized-muted teal)
    elif intensity < 0.5:
        hex_color = "#6c8d7b"  # Medium (Muted green)
    elif intensity < 0.75:
        hex_color = "#8ec07c"  # High (Gruvbox Aqua)
    else:
        hex_color = "#89b482"  # Max (Brighter Aqua)

    return f"<span foreground='{hex_color}'>■</span>"


# Render the graph
def display_graph(contributions):
    max_contrib = max(contributions.values()) if contributions.values() else 1  # Avoid division by zero
    graph = ""

    for day, count in sorted(contributions.items()):  # Ensure correct day order
        intensity = count / max_contrib if max_contrib > 0 else 0
        graph += intensity_to_color(intensity)

    print(graph)

# Fetch contributions and display the graph
if __name__ == "__main__":
    contributions = fetch_contributions()
    display_graph(contributions)

