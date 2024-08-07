#!/bin/bash

# sites.txt: file with list of sites
SITES_FILE="sites.txt"
# sites_status.txt: file for storing site statuses
STATUS_FILE="sites_status.txt"
# Check interval in minutes (2 minutes)
CHECK_INTERVAL=2
# Unavailability threshold in minutes (15 minutes)
UNAVAILABLE_THRESHOLD=$((15 / CHECK_INTERVAL))
# Telegram Bot Token
TELEGRAM_BOT_TOKEN="YOUR_TELEGRAM_BOT_TOKEN"
# Telegram Chat ID
TELEGRAM_CHAT_ID="YOUR_TELEGRAM_CHAT_ID"

cd "$(dirname "$0")"

# Function for sending notifications
send_notification() {
    local site=$1
    DATA='{"channel":"Your channel","text":"The site '
    DATA+="$site"
    DATA+=" is unavailable for more than 15 minutes!"
    DATA+='"}'

    # Send message to Slack
    curl -X POST -H 'Content-type: application/json' --data "$DATA" https://hooks.slack.com/services/TRXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX

    ## Here you can add sending email or other types of notifications
    # echo "The site $site is unavailable for more than 15 minutes!"

    ## Telegram part
    # local message="The site $site is unavailable for more than 15 minutes!"
    # curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    #     -d chat_id="${TELEGRAM_CHAT_ID}" \
    #     -d text="${message}"
}

# Initialize site status if file does not exist
if [ ! -f "$STATUS_FILE" ]; then
    > "$STATUS_FILE"
    while IFS= read -r site; do
        echo "$site 0" >> "$STATUS_FILE"
    done < "$SITES_FILE"
fi

# Checking website availability
while IFS= read -r site; do
    # Checking website availability
    if curl -s --head --request GET "$site" | grep "200" > /dev/null; then
        # Сайт доступен, сбрасываем счётчик недоступности
        sed -i "s|^$site .*|$site 0|" "$STATUS_FILE"
    else
        # Сайт недоступен, увеличиваем счётчик недоступности
        current_status=$(grep "^$site " "$STATUS_FILE" | awk '{print $2}')
        new_status=$((current_status + 1))
        sed -i "s|^$site .*|$site $new_status|" "$STATUS_FILE"
        if [ "$new_status" -gt "$UNAVAILABLE_THRESHOLD" ]; then
            send_notification "$site"
        fi
    fi
done < "$SITES_FILE"