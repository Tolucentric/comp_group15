#!/bin/bash
source "../utils/logger.sh"
source "../utils/helpers.sh"

BACKUP_DIR="./backups"
mkdir -p "$BACKUP_DIR"

function show_header() {
  clear
  echo "----------------------------------------"
  echo "            BACKUP UTILITY"
  echo "----------------------------------------"
}

function perform_backup() {
  read -rp "Enter path to back up: " src
  validate_directory "$src" || return

  filename="$(basename "$src")-$(date +%Y%m%d_%H%M%S).tar.gz"
  target="$BACKUP_DIR/$filename"
  sudo tar -czf "$target" "$src"
  echo "[✓] Backup saved as: $target"
  log_action "Backup created: $src to $target"
}

function perform_restore() {
  echo ""
  echo "Available backups:"
  ls "$BACKUP_DIR"/*.tar.gz 2>/dev/null || { echo "No backups found."; return; }

  read -rp "Enter backup file name (only): " file
  validate_file "$BACKUP_DIR/$file" || return
  read -rp "Restore to which directory? " dest
  mkdir -p "$dest"
  sudo tar -xzf "$BACKUP_DIR/$file" -C "$dest"
  echo "[✓] Restored to $dest"
  log_action "Restored $file to $dest"
}

function backup_menu() {
  while true; do
    show_header
    echo "Options:"
    echo " [1] Create Backup"
    echo " [2] Restore Backup"
    echo " [3] Back to Dashboard"
    echo "----------------------------------------"
    read -rp "Choose an option [1-3]: " option

    case "$option" in
      1) perform_backup ;;
      2) perform_restore ;;
      3) break ;;
      *) echo "[!] Invalid option."; sleep 1 ;;
    esac
  done
}

log_action "Backup Utility Module Accessed"
backup_menu
