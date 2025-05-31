#!/bin/bash

# === INPUT VALIDATORS ===

function validate_number() {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    return 0
  else
    echo "[!] Invalid number: $1"
    return 1
  fi
}

function validate_non_empty() {
  if [[ -z "$1" ]]; then
    echo "[!] Input cannot be empty."
    return 1
  fi
  return 0
}

function validate_username() {
  if [[ "$1" =~ ^[a-z_][a-z0-9_-]*[$]?$ ]]; then
    return 0
  else
    echo "[!] Invalid username format."
    return 1
  fi
}

function validate_directory() {
  if [[ ! -d "$1" ]]; then
    echo "[!] Directory does not exist: $1"
    return 1
  fi
  return 0
}

function validate_file() {
  if [[ ! -f "$1" ]]; then
    echo "[!] File does not exist: $1"
    return 1
  fi
  return 0
}

function pause() {
  read -rp "Press Enter to continue... "
}
