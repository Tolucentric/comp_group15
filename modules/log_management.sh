#!/bin/bash
source "../utils/logger.sh"

function show_header() {
  clear
  echo "----------------------------------------"
  echo "             LOG ANALYSIS"
  echo "----------------------------------------"
}

function list_log_files() {
  echo ""
  echo "  Available Logs:"
  echo "  1) /var/log/syslog     - General system logs"
  echo "  2) /var/log/auth.log   - Authentication logs"
  echo "  3) /var/log/dmesg      - Kernel ring buffer"
  echo ""
}

function view_recent_logs() {
  list_log_files
  read -rp "Choose a log file [1-3]: " opt
  case "$opt" in
    1) file="/var/log/syslog" ;;
    2) file="/var/log/auth.log" ;;
    3) file="/var/log/dmesg" ;;
    *) echo "[!] Invalid choice."; return ;;
  esac

  echo ""
  echo "Last 20 lines of $file:"
  echo ""
  sudo tail -n 20 "$file"
  log_action "Viewed last 20 lines from $file"
  echo ""
}

function search_logs_by_keyword() {
  list_log_files
  read -rp "Choose a log file [1-3]: " opt
  case "$opt" in
    1) file="/var/log/syslog" ;;
    2) file="/var/log/auth.log" ;;
    3) file="/var/log/dmesg" ;;
    *) echo "[!] Invalid choice."; return ;;
  esac

  read -rp "Enter keyword to search: " keyword
  echo ""
  echo "Matches for '$keyword' in $file:"
  echo ""
  sudo grep -i --color=always "$keyword" "$file" | tail -n 20
  log_action "Searched logs in $file for keyword: $keyword"
  echo ""
}

function tail_live_logs() {
  list_log_files
  read -rp "Choose a log file [1-3]: " opt
  case "$opt" in
    1) file="/var/log/syslog" ;;
    2) file="/var/log/auth.log" ;;
    3) file="/var/log/dmesg" ;;
    *) echo "[!] Invalid choice."; return ;;
  esac

  echo ""
  echo "Tailing $file (Press Ctrl+C to stop)"
  echo ""
  log_action "Tailing live logs from $file"
  sudo tail -f "$file"
}

function log_menu() {
  while true; do
    show_header
    echo "Options:"
    echo " [1] View Recent Log Entries"
    echo " [2] Search Logs by Keyword"
    echo " [3] Tail Logs in Real Time"
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
