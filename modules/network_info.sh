#!/bin/bash
# Network Information Module
# Version 1.0

### ----------------------------
### Main Menu Function
### ----------------------------
network_menu() {
    while true; do
        clear
        echo "=============================="
        echo "     Network Information      "
        echo "=============================="
        echo "1. Show IP Addresses"
        echo "2. Show Routing Table"
        echo "3. Show Open Ports"
        echo "4. Test Network Connectivity"
        echo "5. DNS Information"
        echo "6. Network Interfaces"
        echo "7. Return to Main Menu"
        echo "=============================="
        read -p "Enter your choice [1-7]: " choice

        case $choice in
            1) show_ips ;;
            2) show_routing ;;
            3) show_ports ;;
            4) test_connectivity ;;
            5) show_dns ;;
            6) show_interfaces ;;
            7) return ;;
            *) echo "Invalid choice!"; sleep 1 ;;
        esac
    done
}
show_ips() {
    clear
    echo "===== IP Address Information ====="
    echo "Public IP: $(curl -s ifconfig.me)"
    echo ""
    echo "Local IP Addresses:"
    ip -brief address show
    read -p "Press [Enter] to continue..."
}
show_routing() {
    clear
    echo "===== Routing Table ====="
    ip route show
    read -p "Press [Enter] to continue..."
}
show_ports() {
    clear
    echo "===== Listening Ports ====="
    echo "Press 'q' to exit this view"
    sleep 1
    ss -tulnp | less
}
test_connectivity() {
    clear
    echo "===== Network Tests ====="
    read -p "Enter host to test (e.g., google.com): " host
    
    echo -e "\nPing Test:"
    ping -c 4 $host
    
    echo -e "\nTraceroute:"
    traceroute $host
    
    read -p "Press [Enter] to continue..."
}
show_dns() {
    clear
    echo "===== DNS Configuration ====="
    cat /etc/resolv.conf | grep -v "^#"
    
    echo -e "\nTesting DNS resolution:"
    nslookup google.com
    
    read -p "Press [Enter] to continue..."
}
show_interfaces() {
    clear
    echo "===== Network Interfaces ====="
    echo "Press 'q' to exit this view"
    sleep 1
    ifconfig -a | less
}
### Start the module
network_menu
