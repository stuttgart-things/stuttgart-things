#!/bin/bash
#ADDRESS=https://homerun.fluxdev-2.sthings-vsphere.labul.sva.de/generic
#ADDRESS=https://homerun.homerun-dev.sthings-vsphere.labul.sva.de/generic
#ADDRESS=https://k3s-sprechstunde.labul.sva.de/generic

read -p "ENTER COUNT MESSAGES [5]: " COUNT_MESSAGE
COUNT_MESSAGE=${COUNT_MESSAGE:-5}
echo $COUNT_MESSAGE

read -p "ENTER ADDRESS [https://homerun.homerun-dev.sthings-vsphere.labul.sva.de/generic]: " ADDRESS
ADDRESS=${ADDRESS:-https://homerun.homerun-dev.sthings-vsphere.labul.sva.de/generic}
echo $ADDRESS

read -p "ENTER DELAY [10]: " DELAY
DELAY=${DELAY:-5}
echo $DELAY

# POSSIBLE DATA
SYSTEMS=("github" "gitlab") #) "flux" "ansible")
TITLES=("System Alert" "System Incident" "Incident")
MESSAGES=("Memory usage is high" "CPU usage is high" "Memory and CPU usage is high")
SEVERITES=("INFO" "ERROR" "WARNING")
AUTHORS=("bibi" "gude" "andreu" "qolf" "pat")
ARTIFACTS=("image-1.23.tar.gz" "test.tar.gz" "report.json" "result.txt")
TAGS=("usage,alert" "cpu" "cpu,usage,alert" "memory,usage,alert" "monitoring,usage,alert, memory")

# FUNCTION TO GET A RANDOM ITEM FROM A LIST
get_random_item() {
  local items=("$@")
  local count=${#items[@]}
  local random_index=$((RANDOM % count))
  echo "${items[$random_index]}"
}

generate_random_email() {
    local domains=("example.com" "test.com" "mail.com" "demo.com")
    local chars=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
    local length=8
    local local_part=""

    for i in $(seq 1 $length); do
        local_part+=${chars:RANDOM%${#chars}:1}
    done

    local domain=${domains[RANDOM%${#domains[@]}]}
    echo "${local_part}@${domain}"
}

# Function to generate a random ISO 8601 timestamp
generate_random_timestamp() {
  # Generate random values for the timestamp components
  local year=$((RANDOM % 10 + 2024))          # Random year from 2024 to 2033
  local month=$(printf "%02d" $((RANDOM % 12 + 1)))  # Random month from 01 to 12
  local day=$(printf "%02d" $((RANDOM % 28 + 1)))    # Random day from 01 to 28
  local hour=$(printf "%02d" $((RANDOM % 24)))       # Random hour from 00 to 23
  local minute=$(printf "%02d" $((RANDOM % 60)))     # Random minute from 00 to 59
  local second=$(printf "%02d" $((RANDOM % 60)))     # Random second from 00 to 59

  # Construct the ISO 8601 timestamp
  echo "${year}-${month}-${day}T${hour}:${minute}:${second}Z"
}

generate_random_url() {
    local protocols=("http" "https")
    local domains=("example.com" "test.com" "site.net" "demo.org" "mydomain.io")
    local chars=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
    local sub_length=6
    local path_length=10
    local subdomain=""
    local path=""

    # Wähle ein zufälliges Protokoll
    local protocol=${protocols[RANDOM % ${#protocols[@]}]}

    # Erzeuge den Subdomain-Teil
    for i in $(seq 1 $sub_length); do
        subdomain+=${chars:RANDOM%${#chars}:1}
    done

    # Wähle eine zufällige Domain
    local domain=${domains[RANDOM % ${#domains[@]}]}

    # Erzeuge den Pfad
    for i in $(seq 1 $path_length); do
        path+=${chars:RANDOM%${#chars}:1}
    done

    # Konstruktion der vollständigen URL
    echo "${protocol}://${subdomain}.${domain}/${path}"
}

for ((i=1; i<=${COUNT_MESSAGE}; i++)); do

  RANDOM_TIMESTAMP=$(generate_random_timestamp)
  #echo "RANDOM TIMESTAMP: ${RANDOM_TIMESTAMP}"

  SYSTEM=$(get_random_item "${SYSTEMS[@]}")
  echo "SYSTEM: ${SYSTEM}"

  TITLE=$(get_random_item "${TITLES[@]}")
  echo "TITLE: ${TITLE}"

  MESSAGE=$(get_random_item "${MESSAGES[@]}")
  echo "MESSAGE: ${MESSAGE}"

  SEVERITY=$(get_random_item "${SEVERITES[@]}")
  echo "SEVERITY: ${SEVERITY}"

  AUTHOR=$(get_random_item "${AUTHORS[@]}")
  echo "AUTHOR: ${AUTHOR}"

  MAIL=$(generate_random_email)
  #echo "RANDOMLY GENERATED E-MAIL: ${MAIL}"

  ASSIGNE=$(get_random_item "${AUTHORS[@]}")
  #echo "ASSIGNE: ${ASSIGNE}"

  TAG=$(get_random_item "${TAGS[@]}")
  echo "TAGS: ${TAG}"

  RANDOM_URL=$(generate_random_url)
  #echo "URLS: ${RANDOM_URL}"

  ARTIFACT=$(get_random_item "${ARTIFACTS[@]}")
  #echo "ARTIFACT: ${ARTIFACT}"

  printf "\nWAITING FOR ${DELAY} SECONDS BEFORE SENDING THE (NEXT) EVENT\n"
  sleep "$DELAY"  # Pause für die angegebene Anzahl von Sekunden zwischen den Events

  curl -k -X POST "${ADDRESS}" \
      -H "Content-Type: application/json" \
      -H "X-Auth-Token: IhrGeheimerToken" \
      -d "{
            \"title\": \"${TITLE}\",
            \"message\": \"${MESSAGE}\",
            \"severity\": \"${SEVERITY}\",
            \"author\": \"${AUTHOR}\",
            \"timestamp\": \"${RANDOM_TIMESTAMP}\",
            \"system\": \"${SYSTEM}\",
            \"tags\": \"${TAG}\",
            \"assigneeaddress\": \"${MAIL}\",
            \"assigneename\": \"${ASSIGNE}\",
            \"artifacts\": \"${ARTIFACT}\",
            \"url\": \"${RANDOM_URL}\"
          }"

  printf "\n\n"

done