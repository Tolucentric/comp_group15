#!/bin/bash
# Service Management Module
# Version 1.0

### ----------------------------
### Main Menu Function
### ----------------------------
service_menu() {
    while true; do
        clear
        echo "=============================="
        echo "     Service Management      "
        echo "=============================="
        echo "1. List All Services"
        echo "2. Start a Service"
        echo "3. Stop a Service"
        echo "4. Restart a Service"
        echo "5. Check Service Status"
        echo "6. Enable Service at Boot"
        echo "7. Disable Service at Boot"
        echo "8. View Service Logs"
        echo "9. Return to Main Menu"
        echo "=============================="
        read -p "Enter your choice [1-9]: " choice

        case $choice in
            1) list_services ;;
            2) start_service ;;
            3) stop_service ;;
            4) restart_service ;;
            5) check_status ;;
            6) enable_service ;;
            7) disable_service ;;
            8) view_logs ;;
            9) return ;;
            *) echo "Invalid choice!"; sleep 1 ;;
        esac
    done
}
list_services() {
    echo "Listing all services..."
    echo "Press 'q' to return to menu"
    sleep 1
    
    # Check if system uses systemd (modern systems)
    if command -v systemctl &> /dev/null; then
        systemctl list-unit-files --type=service | less
    else
        # Fallback for older systems
        service --status-all | less
    fi
}
start_service() {
    read -p "Enter service name to start: " service_name
    if [ -z "$service_name" ]; then
        echo "Error: No service name entered!"
        sleep 1
        return
    fi
    
    echo "Attempting to start $service_name..."
    if sudo systemctl start "$service_name"; then
        echo "Successfully started $service_name"
    else
        echo "Failed to start $service_name"
    fi
    sleep 2
}
stop_service() {
    read -p "Enter service name to stop: " service_name
    if [ -z "$service_name" ]; then
        echo "Error: No service name entered!"
        sleep 1
        return
    fi
    
    echo "Attempting to stop $service_name..."
    if sudo systemctl stop "$service_name"; then
        echo "Successfully stopped $service_name"
    else
        echo "Failed to stop $service_name"
    fi
    sleep 2
}
restart_service() {
    read -p "Enter service name to restart: " service_name
    if [ -z "$service_name" ]; then
        echo "Error: No service name entered!"
        sleep 1
        return
    fi
    
    echo "Attempting to restart $service_name..."
    if sudo systemctl restart "$service_name"; then
        echo "Successfully restarted $service_name"
    else
        echo "Failed to restart $service_name"
    fi
    sleep 2
}
check_status() {
    read -p "Enter service name to check: " service_name
    if [ -z "$service_name" ]; then
        echo "Error: No service name entered!"
        sleep 1
        return
    fi
    
    clear
    echo "===== Status of $service_name ====="
    systemctl status "$service_name" --no-pager
    read -p "Press [Enter] to continue..."
}
enable_service() {
    read -p "Enter service name to enable at boot: " service_name
    if [ -z "$service_name" ]; then
        echo "Error: No service name entered!"
        sleep 1
        return
    fi
    
    if sudo systemctl enable "$service_name"; then
        echo "Successfully enabled $service_name to start at boot"
    else
        echo "Failed to enable $service_name"
    fi
    sleep 2
}
disable_service() {
    read -p "Enter service name to disable at boot: " service_name
    if [ -z "$service_name" ]; then
        echo "Error: No service name entered!"
        sleep 1
        return
    fi
    
    if sudo systemctl disable "$service_name"; then
        echo "Successfully disabled $service_name from starting at boot"
    else
        echo "Failed to disable $service_name"
    fi
    sleep 2
}
view_logs() {
    read -p "Enter service name to view logs: " service_name
    if [ -z "$service_name" ]; then
        echo "Error: No service name entered!"
        sleep 1
        return
    fi
    
    clear
    echo "===== Logs for $service_name ====="
    journalctl -u "$service_name" --no-pager | less
}
### Start the module
service_menu
