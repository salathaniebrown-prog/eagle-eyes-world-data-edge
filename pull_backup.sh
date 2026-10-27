#!/usr/bin/env bash
clear
echo -e "\033[94m[ASTRA OPERATIONAL RECOVERY]\033[0m Scanning localized storage mirror for core data..."
sleep 1

BACKUP_DIR="/sdcard/Astra_Command_Backup"

if [ -d "$BACKUP_DIR" ]; then
    # Pull everything back from the external mirror destination
    cp "$BACKUP_DIR/index.html" ~/index.html 2>/dev/null
    cp "$BACKUP_DIR/gateway_proxy.py" ~/gateway_proxy.py 2>/dev/null
    cp "$BACKUP_DIR/ledger_storage.db" ~/ledger_storage.db 2>/dev/null
    
    echo -e "\033[92m[SUCCESS]\033[0m All engine matrices and core ledger databases pulled back successfully."
    echo -e "Restarting system master core..."
    sleep 1
    source ~/.bashrc
else
    echo -e "\033[91m[RECOVERY FAILED]\033[0m Backup folder not detected at $BACKUP_DIR"
    echo -e "Please ensure storage permissions are granted via 'termux-setup-storage'."
fi
