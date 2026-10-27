#!/usr/bin/env bash
clear
echo -e "\033[94m[ASTRA OPERATIONS]\033[0m Initializing secure command center nodes..."

# Kill any existing stray processes to free up ports safely
pkill -f "gateway_proxy.py" > /dev/null 2>&1
pkill -f "http.server" > /dev/null 2>&1
sleep 1

# Run the modules using nohup so the system doesn't instantly terminate them
nohup python3 ~/gateway_proxy.py > ~/proxy_boot.log 2>&1 &
nohup python3 -m http.server 8080 > ~/web_boot.log 2>&1 &
sleep 1

# Execute your secure localized system mirror backup
~/backup_matrix.sh

echo -e "\033[92m[ALL LAYERS ARMED]\033[0m System workstation live and isolated."
echo -e "👉 Dashboard Interface: http://localhost:8080"
echo -e "👉 API Data Channel:   http://localhost:8089"
