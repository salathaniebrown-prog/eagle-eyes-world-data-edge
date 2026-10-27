#!/data/data/com.termux/files/usr/bin/bash
cd ~/chronicle-analytics
pkill -f termux-line-motor.cjs 2>/dev/null
pkill -f server.cjs 2>/dev/null
rm -f motor.log server.log
nohup node termux-line-motor.cjs > motor.log 2>&1 &
nohup node server.cjs > server.log 2>&1 &
sleep 3
echo "=== NEXUS-NODE-BROWN AUTO-START ==="
cat public/card-6119-balance.json
echo ""
echo "Local board: http://localhost:3000/board.html"
echo "To go public, run: cloudflared tunnel --url http://localhost:3000"
