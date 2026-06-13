#!/usr/bin/env bash
PROJECT_NAME="attendance_tracker"
cleanup() {
        echo "Interrupted! Archiving and cleaning up..."
        if [ -d "${TARGET_DIR}" ]; then
                tar -czf "${TARGET_DIR}_archive.tar.gz" "${TARGET_DIR}"
                rm -rf "${TARGET_DIR}"
        fi
        exit
}
trap cleanup SIGINT
read -p "Enter the project suffix (e.g. v1):" INPUT
TARGET_DIR="${PROJECT_NAME}_${INPUT}"
mkdir -p "${TARGET_DIR}/Helpers"
mkdir -p "${TARGET_DIR}/reports"
cp attendance_checker.py "${TARGET_DIR}/attendance_checker.py"
cp assets.csv "${TARGET_DIR}/Helpers/assets.csv"
cp config.json "${TARGET_DIR}/Helpers/config.json"
cp reports.log "${TARGET_DIR}/reports/reports.log"
read -p "Do you want to update the warning and failure thresholds? (Y/N): " ANSWER
ANSWER=$(echo "$ANSWER" | tr '[:upper:]' '[:lower:]')
if [ "$ANSWER" = "y" ]; then
        echo "yes"
read -p "Please enter the new warning threshold: " warn_val
if [[ "$warn_val" =~ ^[0-9]+$ ]]; then
        echo "valid"
sed -i 's/"warning": [0-9]*/"warning": '"$warn_val"'/' "${TARGET_DIR}/Helpers/config.json"
else
        echo "invalid"
fi
read -p "Please enter the new failure threshold: " fail_val
if [[ "$fail_val" =~ ^[0-9]+$ ]]; then
        echo "valid"
 sed -i 's/"failure": [0-9]*/"failure": '"$fail_val"'/' "${TARGET_DIR}/Helpers/config.json"
else
        echo "invalid"
fi
else
        echo "no"
fi
if command -v python3 > /dev/null 2>&1; then
        echo "Success: python3 is installed"
        python3 --version
else
        echo "Warning: python3 is not installed"
fi
if [[ -f "${TARGET_DIR}/attendance_checker.py" ]] && [[ -d "${TARGET_DIR}/Helpers" ]] && [[ -d "${TARGET_DIR}/reports" ]]; then
        echo "****Directory Structure is SUCCESSFULLY verified****"
else
        echo -e "******ALERT!!!******:\nSetup failed - directory structure is invalid"
fi
