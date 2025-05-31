#!/bin/bash
source "../utils/logger.sh"

function show_header() {
  clear
  echo "----------------------------------------"
  echo "             LOG ANALYSIS"
  echo "----------------------------------------"
}

function select_log_file() {
  echo ""
  echo "  1) /var/log/syslog"
  echo "  2) /var/log/auth.log"
  echo "  3) /var/log/dmesg"
  read -rp "Select a log file [1-3]: " opt
  case "$opt" in
    1) echo "/var/log/syslog" ;;
    2) echo "/var/log/auth.log" ;;
    3) echo "/var/log/dmesg" ;;
    *) echo ""; return 1 ;;
  esac
}

function view_recent_logs() {
  file=$(select_log_file) || { echo "[!] Invalid selection."; return; }
  echo ""
  echo "Last 20 lines of $file:"
  sudo tail -n 20 "$file"
  log_action "Viewed $file"
  echo ""
}

function search_logs_by_keyword() {
  file=$(select_log_file) || { echo "[!] Invalid selection."; return; }
  read -rp "Enter keyword: " keyword
  echo ""
  sudo grep -i "$keyword" "$file" | tail -n 20
  log_action "Searched $file for $keyword"
  echo ""
}

function tail_live_logs() {
  file=$(select_log_file) || { echo "[!] Invalid selection."; return; }
  echo "Tailing $file (Ctrl+C to stop)"
  log_action "Live tailed $file"
  sudo tail -f "$file"
}

function log_menu() {
  while true; do
    show_header
    echo "Options:"
    echo " [1] View Recent Logs"
    echo " [2] Search Logs by Keyword"
    echo " [3] Tail Logs Live"
    echo " [4] Back to Dashboard"
    echo "----------------------------------------"
    read -rp "Choose an option [1-4]: " option

    case "$option" in
      1) view_recent_logs ;;
      2) search_logs_by_keyword ;;
      3) tail_live_logs ;;
      4) break ;;
      *) echo "[!] Invalid option."; sleep 1 ;;
    esac
  done
}

log_action "Log Analysis Module Accessed"
log_menu
