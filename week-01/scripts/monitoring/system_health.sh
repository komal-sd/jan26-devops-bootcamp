#!/bin/bash
# ─────────────────────────────────────────────────────────────
# Script Name:  system_health.sh
# Description:  Monitors system health - CPU, Memory, Disk
# Author:       Komal
# Created:      March 2026
# Usage:        ./system_health.sh
# ─────────────────────────────────────────────────────────────

set -e
set -u
set -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
readonly REPORT_DIR="./reports"
readonly REPORT_FILE="${REPORT_DIR}/health_$(date '+%Y%m%d_%H%M%S').log"
readonly THRESHOLD_CPU=80
readonly THRESHOLD_DISK=85
readonly THRESHOLD_MEM=80

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
    local level="$1"
    local message="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [${level}] ${message}"
}

check_cpu() {
    log "INFO" "Checking CPU usage..."
    local cpu_idle
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
    local cpu_usage=$((100 - cpu_idle))
    if [ "${cpu_usage}" -ge "${THRESHOLD_CPU}" ]; then
        echo -e "${RED}[CRITICAL] CPU Usage: ${cpu_usage}%${NC}"
        log "CRITICAL" "CPU usage is ${cpu_usage}% - above threshold!"
    else
        echo -e "${GREEN}[OK] CPU Usage: ${cpu_usage}%${NC}"
        log "INFO" "CPU usage is ${cpu_usage}% - normal"
    fi
}

check_memory() {
    log "INFO" "Checking memory usage..."
    local total_mem used_mem mem_usage
    total_mem=$(free -m | awk '/^Mem:/{print $2}')
    used_mem=$(free -m | awk '/^Mem:/{print $3}')
    mem_usage=$(( (used_mem * 100) / total_mem ))
    if [ "${mem_usage}" -ge "${THRESHOLD_MEM}" ]; then
        echo -e "${RED}[CRITICAL] Memory: ${mem_usage}% (${used_mem}MB / ${total_mem}MB)${NC}"
        log "CRITICAL" "Memory usage is ${mem_usage}% - above threshold!"
    else
        echo -e "${GREEN}[OK] Memory: ${mem_usage}% (${used_mem}MB / ${total_mem}MB)${NC}"
        log "INFO" "Memory usage is ${mem_usage}% - normal"
    fi
}

check_disk() {
    log "INFO" "Checking disk usage..."
    while IFS= read -r line; do
        local usage mount
        usage=$(echo "$line" | awk '{print $5}' | cut -d% -f1)
        mount=$(echo "$line" | awk '{print $6}')
        if [ "${usage}" -ge "${THRESHOLD_DISK}" ]; then
            echo -e "${RED}[CRITICAL] Disk ${mount}: ${usage}% used${NC}"
            log "CRITICAL" "Disk ${mount} is ${usage}% full!"
        else
            echo -e "${GREEN}[OK] Disk ${mount}: ${usage}% used${NC}"
            log "INFO" "Disk ${mount} is ${usage}% used - normal"
        fi
    done < <(df -h | grep -vE '^Filesystem|tmpfs|cdrom')
}

check_services() {
    log "INFO" "Checking critical services..."
    local services=("docker" "ssh")
    for service in "${services[@]}"; do
        if systemctl is-active --quiet "$service" 2>/dev/null; then
            echo -e "${GREEN}[OK] Service ${service}: running${NC}"
        else
            echo -e "${YELLOW}[WARNING] Service ${service}: not running${NC}"
        fi
    done
}

main() {
    log "INFO" "Starting ${SCRIPT_NAME}"
    echo "======================================"
    echo "  SYSTEM HEALTH CHECK - $(date)"
    echo "======================================"
    check_cpu
    check_memory
    check_disk
    check_services
    echo "======================================"
    log "INFO" "${SCRIPT_NAME} completed"
}

main "$@"
