unset DISPLAY

# Ensure the mouse mode is set in tmux
echo "set -g mouse on" >> ~/.tmux.conf
caddy stop
# Kill existing tmux session if it exists
tmux kill-session -t server 2>/dev/null
# Function to clean up logs
cleanup_logs() {
		caddy stop
		echo "Cleaning up logs..."
		rm -f ./1.8/logs/*.log
		rm -f ./WaterFall/logs/*.log
}

# Trap to ensure cleanup happens on exit
trap cleanup_logs EXIT

# Restart Caddy server, port forwarding 8081 for Eaglercraft
cd ./Caddy
caddy stop
caddy start --config ./Caddyfile > /dev/null 2>&1
cd ..

# Create tmux session for the server
tmux new-session -d -s server

# Run Paper Server in the first window (1.8 folder)
tmux send-keys -t server "cd ./1.8 && java -Xms512M -Xmx512M -jar paper-1.8.8-445.jar" C-m

# Split the window horizontally for Waterfall
tmux split-window -h -t server

# Run Waterfall Server in the second window (WaterFall folder)
tmux send-keys -t server:0.1 "cd ./WaterFall && java -Xms512M -Xmx512M -jar waterfall-1.16-431.jar" C-m

# Attach to the session
tmux attach-session -t server