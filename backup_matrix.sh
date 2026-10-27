#!/usr/bin/env bash
# Termux Local Storage Array External Mirror Synchronization Script
BACKUP_DIR="/sdcard/Astra_Command_Backup"

if [ -d "/sdcard" ]; then
    mkdir -p "$BACKUP_DIR"
    cp ~/index.html "$BACKUP_DIR/index.html"
    cp ~/gateway_proxy.py "$BACKUP_DIR/gateway_proxy.py"
    cp ~/ledger_storage.db "$BACKUP_DIR/ledger_storage.db" 2>/dev/null || true
    echo -e "\033[92m[BACKUP MATRIX COMPLETED]\033[0m Secure structural mirror synced to storage: $BACKUP_DIR"
else
    echo -e "\033[91m[BACKUP WARNING]\033[0m Access denied. Ensure 'termux-setup-storage' path has been granted."
fi
