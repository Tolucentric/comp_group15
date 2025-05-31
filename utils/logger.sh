#!/bin/bash

LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/dashboard.log"

mkdir -p "$LOG_DIR"

function log_action() {
  echo "[ACTION] $(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

function log_error() {
  echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}
