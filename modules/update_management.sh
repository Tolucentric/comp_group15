#!/bin/bash
source "../utils/logger.sh"

UPDATE_LOG="./logs/update.log"

function show_header() {
  clear
  echo "----------------------------------------"
  echo "            SYSTEM UPDATE"
  echo "----------------------------------------"
}

function check_updates() {
  echo ""
  echo "[✓] Checking for updates..."
  sudo apt update -y > /tmp/update_result.txt
  grep -E "packages can be upgraded" /tmp/update_result.txt || echo "All packages are up to date."
  echo ""
  log_action "Checked for updates"
}

function apply_updates() {
  echo ""
  echo "[✓] Applying updates..."
  sudo apt update && sudo apt upgrade -y | tee -a "$UPDATE_LOG"
  log_action "System updates applied"
  echo ""
}

function show_last_update() {
  echo ""
  if [[ -f "$UPDATE_LOG" ]]; then
    echo "Last update performed on:"
    tail -n 1 "$UPDATE_LOG" | cut -d' ' -f1-4
  else
    echo "No update history found."
  fi
  echo ""
}

function update_menu() {
  while true; do
    show_header
    echo "Options:"
    echo " [1] Check for Updates"
    echo " [2] Apply Updates"
    echo " [3] Show Last Update Time"
    echo " [4] Back to Dashboard"
    echo "----------------------------------------"
    read -rp "Choose an option [1-4]: " option

    case "$option" in
      1) check_updates ;;
      2) apply_updates ;;
      3) show_last_update ;;
      4) break ;;
      *) echo "[!] Invalid option."; sleep 1 ;;
    esac
  done
}

log_action "System Update Module Accessed"
update_menu
