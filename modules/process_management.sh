#!/bin/bash
# Process Management Module
# Version 1.0.0

### ----------------------------
### Main Menu Function
### ----------------------------
process_menu() {
    while true; do
        clear
        echo "=============================="
        echo "    Process Management       "
        echo "=============================="
        echo "1. List Running Processes"
        echo "2. Search for a Process"
        echo "3. Kill a Process"
        echo "4. Monitor Processes (Real-Time)"
        echo "5. Return to Main Menu"
        echo "=============================="
        read -p "Enter your choice [1-5]: " choice

        case $choice in
            1) list_processes ;;
            2) search_process ;;
            3) kill_process ;;
            4) monitor_processes ;;
            5) exit 0 ;;
            *) echo "Invalid choice! Try again."; sleep 1 ;;
        esac
    done
}

### ----------------------------
### Function Definitions
### ----------------------------
list_processes() {
    echo "Listing all running processes..."
    ps aux | less  # Shows processes in scrollable mode
    read -p "Press [Enter] to return to menu..."
}

search_process() {
    read -p "Enter process name to search: " process_name
    if [ -z "$process_name" ]; then
        echo "Error: No process name entered!"
        sleep 1
        return
    fi
    ps aux | grep -i "$process_name" | less
    read -p "Press [Enter] to return to menu..."
}

kill_process() {
    read -p "Enter PID (Process ID) to kill: " pid
    if ! [[ "$pid" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid PID! Must be a number."
        sleep 1
        return
    fi
    kill -9 "$pid" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Process $pid killed successfully!"
    else
        echo "Failed to kill process $pid (does it exist?)"
    fi
    sleep 2
}

monitor_processes() {
    echo "Opening real-time process monitor (Press 'q' to quit)..."
    top
}

### ----------------------------
### Start the Module
### ----------------------------
process_menu
