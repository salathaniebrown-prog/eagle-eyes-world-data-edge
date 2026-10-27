#!/usr/bin/env bash

STATS_FILE="internal_stats.json"

while true; do
    clear
    echo -e "\033[1;35m=========================================================\033[0m"
    echo -e "🧠 \033[1;37mASTRA SOVEREIGN GLOBAL AI SUPERCOMPUTER CORE TELEMETRY\033[0m"
    echo -e "\033[1;35m=========================================================\033[0m"
    echo ""

    if [ -f "$STATS_FILE" ]; then
        total_req=$(grep -o '"totalRequests":[0-9]*' "$STATS_FILE" | cut -d: -f2)
        active_conn=$(grep -o '"activeConnections":[0-9]*' "$STATS_FILE" | cut -d: -f2)
        current_rps=$(grep -o '"currentRps":[0-9]*' "$STATS_FILE" | cut -d: -f2)

        # Render data using highly clean visual elements
        echo -e "📊 Global Compute Volumetric Rate: \033[1;32m$current_rps Requests/Sec (RPS)\033[0m"
        
        # Live visual progress bar mapping current load dynamics
        bar_size=$((current_rps / 50))
        if [ "$bar_size" -gt 30 ]; then bar_size=30; fi
        echo -n "   ["
        for ((i=0; i<bar_size; i++)); do echo -n "■"; done
        for ((i=bar_size; i<30; i++)); do echo -n " "; done
        echo -e "]"
        
        echo ""
        echo -e "📈 Total Cumulative Transactions : \033[1;34m$total_req\033[0m"
        echo -e "⚡ Active Global Ingress Sockets : \033[1;36m$active_conn\033[0m"
        echo ""
        echo "🔒 International Grid Node Topologies (Top 25 Matrix):"
        echo "--------------------------------------------------------─"

        grep -o '"[0-9]*":{"requests":[0-9]*,"status":"[^"]*"' "$STATS_FILE" | while read -r line; do
            pid=$(echo "$line" | cut -d'"' -f2)
            reqs=$(echo "$line" | grep -o '"requests":[0-9]*' | cut -d: -f2)
            status=$(echo "$line" | grep -o '"status":"[^"]*' | cut -d'"' -f4)
            
            echo -e "  ├── [Node Matrix Thread $pid] \033[1;32m$status\033[0m | Synced Operations: \033[1;33m$reqs\033[0m"
        done
    else
        echo "📡 Scanning for active global supercomputer data packets..."
    fi

    echo ""
    echo -e "\033[1;35m=========================================================\033[0m"
    echo "Sampling Matrix Step: 100ms | Exit Loop: [Ctrl+C]"
    sleep 0.1
done
