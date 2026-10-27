#!/usr/bin/env bash
clear
echo -e "\033[94m[ASTRA HISTORICAL LOGS - LAST 60 DAYS]\033[0m"
echo "--------------------------------------------------------"

# Uses native Python formatting to parse and print rows cleanly with zero dependencies
curl -s http://localhost:8080/api/ledger/history_60d | python3 -m json.tool

echo "--------------------------------------------------------"
