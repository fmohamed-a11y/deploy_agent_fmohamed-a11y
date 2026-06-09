#!/usr/bin/env bash 
PROJECT_NAME="attendance_tracker"
read -p "Enter the project suffix (e.g. v1):" INPUT
TARGET_DIR="${PROJECT_NAME}_${INPUT}"
trap cleanup SIGINT
mkdir -p "${TARGET_DIR}/Helpers"
mkdir -p "${TARGET_DIR}/reports"
touch "${TARGET_DIR}/attendance_checker.py"
touch "${TARGET_DIR}/Helpers/assets.csv"
touch "${TARGET_DIR}/Helpers/config.json"
touch "${TARGET_DIR}/reports/reports.log"
