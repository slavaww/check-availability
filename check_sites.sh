#!/bin/bash

# sites_monitor.conf: file with list of sites
CONFIG_FILE="/etc/sites_monitor.conf"
# Set maximum fails
MAX_FAILS=2
# Telegram Bot Token
BOT_TOKEN="YOUR_TELEGRAM_BOT_TOKEN"
# Telegram Chat ID
CHAT_ID="YOUR_TELEGRAM_CHAT_ID"
# Log
LOG_FILE="/var/log/site_monitor.log"
# Temporary file
FAIL_COUNTER_FILE="/tmp/site_monitor_fails.tmp"

# Config checks
if [ ! -f "$CONFIG_FILE" ]; then
  echo "$timestamp ERROR: Configuration file $CONFIG_FILE not found" >> "$LOG_FILE"
  exit 1
fi

if [ ! -s "$CONFIG_FILE" ]; then
  echo "$timestamp ERROR: Configuration file $CONFIG_FILE empty" >> "$LOG_FILE"
  exit 1
fi

# Functions
check_site() {
  curl -I -s -o /dev/null -w "%{http_code}" --max-time 10 "$1"
}

send_alert() {
    local msg="$1"

    DATA='{"channel":"Your channel","text":"'
    DATA+="$msg"
    DATA+='"}'

    # Send message to Slack
    curl -X POST -H 'Content-type: application/json' --data "$DATA" https://hooks.slack.com/services/TRXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX

    ## Telegram part
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d chat_id="${CHAT_ID}" \
        -d text="$msg" >/dev/null
}

# getting counter
get_fail_count() {
  local domain="$1"
  # We look for the domain in the file, take only numbers, if not, return 0
  count=$(grep "^$domain " "$FAIL_COUNTER_FILE" 2>/dev/null | awk '{print $2}')
  if [[ "$count" =~ ^[0-9]+$ ]]; then
    echo "$count"
  else
    echo "0"
  fi
}

# counter installation
set_fail_count() {
  local domain="$1"
  local count="$2"

  # Checking that count is a number
  if ! [[ "$count" =~ ^[0-9]+$ ]]; then
    count="0"
  fi

  # Create a temporary file
  temp_file=$(mktemp)

  # Delete the old entry if it exists
  grep -v "^$domain " "$FAIL_COUNTER_FILE" 2>/dev/null > "$temp_file"

  # Add a new entry if count > 0
  if [ "$count" -gt 0 ]; then
    echo "$domain $count" >> "$temp_file"
  fi

  # Move the temporary file to the permanent location
  mv "$temp_file" "$FAIL_COUNTER_FILE" 2>/dev/null
}

# Reading a list of sites
read_sites() {
  grep -v '^#' "$CONFIG_FILE" | grep -v '^$'
}

# Initialization
[ ! -f "$FAIL_COUNTER_FILE" ] && touch "$FAIL_COUNTER_FILE"
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Main loop
while read -r site; do
  [ -z "$site" ] && continue

  domain=$(echo "$site" | awk -F/ '{print $3}')
  response=$(check_site "$site")
  fails=$(get_fail_count "$domain")

  if [ "$response" -ne 200 ]; then
    fails=$((fails + 1))
    set_fail_count "$domain" "$fails"
    echo "$timestamp [$domain] ERROR: HTTP $response (attempt $fails/$MAX_FAILS)" >> "$LOG_FILE"

    if [ "$fails" -eq "$MAX_FAILS" ]; then
      send_alert "🔴 $timestamp Website $site unavailable: HTTP $response"
    fi
  else
    if [ "$fails" -ge "$MAX_FAILS" ]; then
      send_alert "✅ $timestamp Website $site available again"
    fi
    set_fail_count "$domain" 0
    echo "$timestamp [$domain] OK: HTTP 200" >> "$LOG_FILE"
  fi
done < <(read_sites)
