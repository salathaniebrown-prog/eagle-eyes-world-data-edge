#!/bin/bash
# ==============================================================================
# SOVEREIGN ENGINE: REAL-TIME LEDGER DATASTREAM WATCHER
# Target Profile: OMEGA-SOVEREIGN-ROOT Transaction Audit Pipeline
# ==============================================================================

LEDGER_FILE="$HOME/chronicle-analytics/data_engine/db_store/deepspace_master_ledger.jsonl"

echo "=================================================================="
echo " 📡 SOVEREIGN LEDGER AUDIT NETWORK DETACHED MONITOR CORE ACTIVE"
echo " Monitoring Stream: $LEDGER_FILE"
echo "=================================================================="

# Check if target ledger data file exists; provision baseline matrix if empty
if [ ! -f "$LEDGER_FILE" ]; then
    echo "  -> [NOTICE] Awaiting initial submission pipeline frame creation..."
fi

# Track, capture, and dump new entry logs on stdout frame updates live
tail -f -n +1 "$LEDGER_FILE" 2>/dev/null | while read -r line; do
    echo -e "\n📥 [LOG RECEIVED] Pipeline Real-Time Payload Appended:"
    echo "------------------------------------------------------------------"
    echo "$line" | python3 -m json.tool 2>/dev/null || echo "$line"
    echo "------------------------------------------------------------------"
done
