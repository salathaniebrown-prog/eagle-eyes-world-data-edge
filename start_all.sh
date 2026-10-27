#!/bin/bash
# =====================================================================
# JETI CORE: AUTOMATED VIRTUAL BINDING & ENDPOINT INITIALIZATION
# =====================================================================
termux-wake-lock
set +e

# 1. Clear hanging server socket bindings
vncserver -kill :1 >/dev/null 2>&1
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

# 2. Re-initialize virtual X11 baseline
vncserver :1 -geometry 1280x720 -depth 24

# 3. Enter target workspace domain and ensure runtime isolation
cd ~/alstra-workspace
if [ ! -d "venv" ]; then
    echo "[!] Virtual environment missing. Generating core runtime isolation matrix..."
    python3 -m venv venv
fi
source venv/bin/activate

# Ensure system speed features are integrated into compilation modules
export MAKEFLAGS="-j$(nproc)"
pip install --upgrade pip > /dev/null 2>&1
pip install fastapi uvicorn numpy > /dev/null 2>&1

# 4. Bind endpoints and ignite multi-threaded API workers
echo "[⚡ API START] Launching FastAPI backend infrastructure on Port 3000..."
nohup uvicorn server:app --host 0.0.0.0 --port 3000 --workers 4 > server.log 2>&1 &

echo "=========================================================="
echo " JETI API EDGE NODE DEPLOYED AND LISTENING ON 0.0.0.0:3000"
echo "=========================================================="
