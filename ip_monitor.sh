
# Path to store the last known IP
IP_FILE="/tmp/last_ip.txt"
EMAIL="deysoumyadeep70@gmail.com"

# Get current IP
get_ip() {
    hostname -I | awk '{print $1}'
}

while true; do
    current_ip=$(get_ip)

    # Check if IP is not empty
    if [[ -n "$current_ip" ]]; then
        # Check if the file exists
        if [[ -f "$IP_FILE" ]]; then
            last_ip=$(cat "$IP_FILE")
        else
            last_ip=""
        fi

        # If IP has changed, send email
        if [[ "$current_ip" != "$last_ip" ]]; then
            echo "$current_ip" > "$IP_FILE"
            echo "New Raspberry Pi IP address: $current_ip" | mail -s "Raspberry Pi IP Changed" "$EMAIL"
        fi
    fi

    sleep 30  # Check every 30 seconds
done
