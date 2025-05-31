#!/bin/bash
source "../utils/logger.sh"

BACKUP_DIR="./backups"

function show_header() {
  clear
  echo "----------------------------------------"
  echo "            BACKUP UTILITY"
  echo "----------------------------------------"
}

function perform_backup() {
  read -rp "Enter full path of directory to back up: " source_path

  if [[ ! -d "$source_path" ]]; then
    echo "[!] Directory does not exist."
    return
  fi

  mkdir -p "$BACKUP_DIR"
  filename="$(basename "$source_path")-$(date +%Y%m%d_%H%M%S).tar.gz"
  target="$BACKUP_DIR/$filename"

  echo "Creating backup: $target"
  sudo tar -czf "$target" "$source_path"
  echo "[✓] Backup completed: $target"
  log_action "Backed up $source_path to $target"
}

function perform_restore() {
  echo ""
  echo "Available backups:"
  ls "$BACKUP_DIR"/*.tar.gz 2>/dev/null || { echo "No backups found."; return; }

  read -rp "Enter full name of backup file to restore: " backup_file
  read -rp "Enter target directory to extract into: " restore_path

  mkdir -p "$restore_path"
  sudo tar -xzf "$BACKUP_DIR/$backup_file" -C "$restore_path"
  echo "[✓] Backup restored to: $restore_path"
  log_action "Restored $backup_file to $restore_path"
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
