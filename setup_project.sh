#!/usr/bin/env bash 
PROJECT_NAME="attendance_tracker"
read -p "Enter the project suffix (e.g. v1):" INPUT
TARGET_DIR="${PROJECT_NAME}_${INPUT}"
cleanup() {
	if [ -d "${TARGET_DIR}" ]; then 
		tar -czf "${TARGET_DIR}_archive.tar.gz" "${TARGET_DIR}"
		rm -rf "${TARGET_DIR}"
	fi
	exit
}
trap cleanup SIGINT 
mkdir -p "${TARGET_DIR}/Helpers"
mkdir -p "${TARGET_DIR}/reports"
cp attendance_checker.py "${TARGET_DIR}/attendance_checker.py"
cp assets.csv "${TARGET_DIR}/Helpers/assets.csv"
cp config.json "${TARGET_DIR}/Helpers/config.json"
cp reports.log "${TARGET_DIR}/reports/reports.log"
read -p "Updated Warning/Failure thresholds?(Y/N): " ANSWER
ANSWER=$(echo "$ANSWER" | tr '[:upper:]' '[:lower:]')
if [ "$ANSWER" = "y" ]; then
	echo "yes"
else
	echo "no"
fi
