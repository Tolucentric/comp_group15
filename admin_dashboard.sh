#!/bin/bash
source "utils/helpers.sh"
source "utils/logger.sh"

# === AUTH LOGIN ===
function prompt_user_login() {
  echo "=============================================="
  echo "       Secure Login - Admin Access Only"
  echo "=============================================="
  echo ""

  non_root_users=$(awk -F: '$3 >= 1000 && $1 != "nobody" { print $1 }' /etc/passwd)
  if [[ -z "$non_root_users" ]]; then
    echo "[!] No admin users found."
    read -rp "Create a new admin username: " new_user
    sudo adduser "$new_user"
    echo "[+] User '$new_user' created. Please log in."
  fi

  while true; do
    read -rp "Username: " login_user
    read -s -p "Password: " login_pass
    echo ""
    echo "$login_pass" | su - "$login_user" -c "exit" &>/dev/null
    if [[ $? -eq 0 ]]; then
      echo "[✓] Login successful."
      export DASHBOARD_USER="$login_user"
      break
    else
      echo "[!] Login failed. Try again."
    fi
  done
}

# === HEADER ===
function show_header() {
  clear
  echo "=============================================="
  echo "             ADMIN DASHBOARD v1.0"
  echo "=============================================="
  printf "Logged in as: %-10s  Date: %s\n" "${DASHBOARD_USER:-$USER}" "$(date '+%Y-%m-%d %H:%M:%S')"
  echo "----------------------------------------------"
}

# === MENU ===
function main_menu() {
  while true; do
    show_header
    echo "Select a module:"
    echo " [1] System Information"
    echo " [2] Process Management"
    echo " [3] Service Management"
    echo " [4] User Management"
    echo " [5] Network Information"
    echo " [6] Log Analysis"
    echo " [7] Backup Utility"
    echo " [8] System Update"
    echo " [9] Exit"
    echo "----------------------------------------------"
    read -rp "Enter your choice [1-9]: " choice

    case "$choice" in
      1) bash "modules/system_info.sh" ;;
      2) bash "modules/process_management.sh" ;;
      3) bash "modules/service_management.sh" ;;
      4) bash "modules/user_management.sh" ;;
      5) bash "modules/network_info.sh" ;;
      6) bash "modules/log_management.sh" ;;
      7) bash "modules/backup_management.sh" ;;
      8) bash "modules/update_management.sh" ;;
      9) echo -e "\nExiting..."; log_action "Dashboard exited"; exit 0 ;;
      *) echo -e "\n[!] Invalid input. Try again."; sleep 1 ;;
    esac
  done
}

prompt_user_login
main_menu
