#!/bin/bash
echo "=== ASTRA SAFE AUTO-RECOVERY ==="
tar -zcf /sdcard/Download/termux-backup.tar.gz -C /data/data/com.termux/files ./home ./usr
echo "=== BACKUP ENTIRELY COMPLETE ==="
