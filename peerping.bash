#!/bin/bash
# Fetch the peer IPs
peers=$(curl -s localhost:26657/net_info | jq -r '.result.peers[].remote_ip')

echo "Pinging peers..."

# Ping each peer and sort based on latency
for peer in $peers; do
    avg_ping=$(ping -c 4 $peer | tail -1| awk '{print $4}' | cut -d '/' -f 2)
    echo "$peer - $avg_ping ms"
done | sort -k3 -n
