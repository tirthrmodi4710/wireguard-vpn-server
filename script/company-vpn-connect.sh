#!/bin/bash

VPN_NAME="$1"

SERVER_IP="YOUR_SERVER_IP"

MACHINE_ID=$(cat /etc/machine-id)

VALIDATION_SERVER="http://SERVER_IP:5005"

# Detect current gateway dynamically
GATEWAY=$(ip route | awk '/default/ {print $3}')

# Preserve direct route to VPN server
sudo ip route add $SERVER_IP via $GATEWAY 2>/dev/null

# Validate machine with server
RESPONSE=$(curl -s -X POST "$VALIDATION_SERVER/validate" \
  -H "Content-Type: application/json" \
  -d "{\"vpn\":\"$VPN_NAME\",\"machine_id\":\"$MACHINE_ID\"}")

# Start VPN only if allowed
if [[ "$RESPONSE" == "ALLOW" ]]; then
    echo "VPN Allowed"
    sudo wg-quick up "$VPN_NAME"
else
    echo "VPN Blocked - Device mismatch"
fi

