#!/bin/bash
set -euo pipefail

# LaunchAgents get a minimal environment; ensure standard paths are available
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:${PATH:-}"

usage() {
    echo "Usage: $(basename "$0") <source-dir> <backup-dest>"
    echo ""
    echo "Creates a compressed tarball backup of a directory."
    echo "Retains 10 backups with rotation. Skips if the most"
    echo "recent backup is less than 24 hours old."
    exit 1
}

[[ $# -ne 2 ]] && usage

SOURCE_DIR="$(cd "$1" 2>/dev/null && pwd)" || { echo "ERROR: Source directory $1 does not exist"; exit 1; }
BACKUP_DEST="$(cd "$2" 2>/dev/null && pwd)" || { echo "ERROR: Backup destination $2 does not exist"; exit 1; }
DIR_NAME="$(basename "$SOURCE_DIR")"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
TARBALL_NAME="${DIR_NAME}-${TIMESTAMP}.tar.gz"
TARBALL_PATH="${BACKUP_DEST}/${TARBALL_NAME}"
MAX_BACKUPS=10
MAX_AGE_SECONDS=86400  # 24 hours

# Validate destination
if [[ ! -d "$BACKUP_DEST" ]]; then
    echo "ERROR: Backup destination ${BACKUP_DEST} does not exist"
    exit 1
fi

# Skip if most recent backup is less than 24 hours old
LATEST=$(ls -t "${BACKUP_DEST}/${DIR_NAME}"-*.tar.gz 2>/dev/null | head -1 || true)

if [[ -n "$LATEST" ]]; then
    LATEST_MTIME=$(stat -f%m "$LATEST")
    NOW=$(date +%s)
    AGE=$(( NOW - LATEST_MTIME ))
    if [[ "$AGE" -lt "$MAX_AGE_SECONDS" ]]; then
        HOURS_REMAINING=$(( (MAX_AGE_SECONDS - AGE) / 3600 ))
        MINS_REMAINING=$(( ((MAX_AGE_SECONDS - AGE) % 3600) / 60 ))
        echo "Skipping: latest backup is $(( AGE / 3600 ))h $(( (AGE % 3600) / 60 ))m old (next in ${HOURS_REMAINING}h ${MINS_REMAINING}m)"
        exit 0
    fi
fi

# Create tarball
echo "Backing up ${SOURCE_DIR} ..."
tar -czf "$TARBALL_PATH" -C "$(dirname "$SOURCE_DIR")" "$DIR_NAME"

TARBALL_SIZE=$(stat -f%z "$TARBALL_PATH")
echo "Created ${TARBALL_NAME} ($(( TARBALL_SIZE / 1024 )) KB)"

# Rotate: remove oldest backups beyond MAX_BACKUPS
BACKUPS=($(ls -t "${BACKUP_DEST}/${DIR_NAME}"-*.tar.gz 2>/dev/null))
if [[ ${#BACKUPS[@]} -gt $MAX_BACKUPS ]]; then
    for OLD in "${BACKUPS[@]:$MAX_BACKUPS}"; do
        echo "Rotating out: $(basename "$OLD")"
        rm -f "$OLD"
    done
fi

REMAINING=($(ls -t "${BACKUP_DEST}/${DIR_NAME}"-*.tar.gz 2>/dev/null))
echo "Done. ${#REMAINING[@]} backup(s) retained for ${DIR_NAME}."
