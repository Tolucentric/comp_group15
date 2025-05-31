#!/bin/bash
source "../utils/logger.sh"

function show_header() {
  clear
  echo "----------------------------------------"
  echo "            USER MANAGEMENT"
  echo "----------------------------------------"
}

function list_users() {
  echo ""
  echo "  USERNAME        UID     GID     HOME                 SHELL"
  echo "  -------------------------------------------------------------"
  awk -F: '{printf "  %-15s %-7s %-7s %-20s %-10s\n", $1, $3, $4, $6, $7}' /etc/passwd | sort
  echo ""
}

function add_user() {
  read -rp "Enter new username: " username
  read -rp "Custom shell (default: /bin/bash): " shell
  shell=${shell:-/bin/bash}

  if id "$username" &>/dev/null; then
    echo "[!] User '$username' already exists."
  else
    sudo useradd -m -s "$shell" "$username" && \
    sudo passwd "$username"
    log_action "User added: $username with shell $shell"
  fi
}

function delete_user() {
  read -rp "Enter username to delete: " username
  if id "$username" &>/dev/null; then
    read -rp "Delete home directory too? [y/N]: " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      sudo deluser --remove-home "$username"
    else
      sudo deluser "$username"
    fi
    log_action "User deleted: $username"
  else
    echo "[!] User '$username' does not exist."
  fi
}

function change_password() {
  read -rp "Enter username to change password: " username
  if id "$username" &>/dev/null; then
    sudo passwd "$username"
    log_action "Password changed for: $username"
  else
    echo "[!] User not found."
  fi
}

function modify_groups() {
  read -rp "Enter username: " username
  if id "$username" &>/dev/null; then
    echo "[1] Add to group"
    echo "[2] Remove from group"
    read -rp "Choose: " opt
    read -rp "Enter group name: " group
    if [[ "$opt" == "1" ]]; then
      sudo usermod -aG "$group" "$username"
      log_action "User '$username' added to group '$group'"
    elif [[ "$opt" == "2" ]]; then
      sudo gpasswd -d "$username" "$group"
      log_action "User '$username' removed from group '$group'"
    else
      echo "[!] Invalid option."
    fi
  else
    echo "[!] User not found."
  fi
}

function set_expiration() {
  read -rp "Enter username: " username
  if id "$username" &>/dev/null; then
    read -rp "Enter expiration date (YYYY-MM-DD): " exp
    sudo chage -E "$exp" "$username"
    log_action "Set expiration for $username to $exp"
  else
    echo "[!] User not found."
  fi
}

function lock_unlock_user() {
  read -rp "Enter username: " username
  if id "$username" &>/dev/null; then
    local status
    status=$(passwd -S "$username" | awk '{print $2}')
    if [[ "$status" == "L" ]]; then
      sudo passwd -u "$username"
      echo "[?] User '$username' unlocked."
      log_action "User unlocked: $username"
    else
      sudo passwd -l "$username"
      echo "[?] User '$username' locked."
      log_action "User locked: $username"
    fi
  else
    echo "[!] User not found."
  fi
}

function show_user_details() {
  read -rp "Enter username: " username
  if id "$username" &>/dev/null; then
    echo ""
    echo "  Username     : $username"
    echo "  UID          : $(id -u "$username")"
    echo "  GID          : $(id -g "$username")"
    echo "  Groups       : $(id -nG "$username")"
    echo "  Home Dir     : $(eval echo "~$username")"
    echo "  Shell        : $(getent passwd "$username" | cut -d: -f7)"
    echo "  Expiration   : $(chage -l "$username" | grep 'Account expires' | cut -d: -f2)"
    echo ""
  else
    echo "[!] User not found."
  fi
}

function user_menu() {
  while true; do
    show_header
    list_users
    echo "Options:"
    echo " [1] Add User"
    echo " [2] Delete User"
    echo " [3] Change Password"
    echo " [4] Add/Remove from Group"
    echo " [5] Set Account Expiration"
    echo " [6] Lock/Unlock Account"
    echo " [7] Show User Details"
    echo " [8] Back to Dashboard"
    echo "----------------------------------------"
    read -rp "Choose an option [1-8]: " option

    case "$option" in
      1) add_user ;;
      2) delete_user ;;
      3) change_password ;;
      4) modify_groups ;;
      5) set_expiration ;;
      6) lock_unlock_user ;;
      7) show_user_details ;;
      8) break ;;
      *) echo "[!] Invalid option."; sleep 1 ;;
    esac
  done
}

log_action "User Mgmt Module Accessed"
user_menu
