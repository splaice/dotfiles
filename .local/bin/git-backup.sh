#!/bin/bash
set -euo pipefail

usage() {
    echo "Usage: $(basename "$0") <repo-path> <backup-dest>"
    echo ""
    echo "Creates a git bundle backup of the repository."
    echo "Retains 7 backups with rotation. Refuses to rotate if"
    echo "the new backup is smaller than the previous one."
    exit 1
}

[[ $# -ne 2 ]] && usage

REPO_PATH="$(cd "$1" && pwd)"
BACKUP_DEST="$(cd "$2" && pwd)"
REPO_NAME="$(basename "$REPO_PATH")"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BUNDLE_NAME="${REPO_NAME}-${TIMESTAMP}.bundle"
BUNDLE_PATH="${BACKUP_DEST}/${BUNDLE_NAME}"
MAX_BACKUPS=7

# Validate repo
if [[ ! -d "${REPO_PATH}/.git" ]] && ! git -C "$REPO_PATH" rev-parse --git-dir &>/dev/null; then
    echo "ERROR: ${REPO_PATH} is not a git repository"
    exit 1
fi

# Validate destination
if [[ ! -d "$BACKUP_DEST" ]]; then
    echo "ERROR: Backup destination ${BACKUP_DEST} does not exist"
    exit 1
fi

# Create bundle
echo "Bundling ${REPO_PATH} ..."
git -C "$REPO_PATH" bundle create "$BUNDLE_PATH" --all

# Verify the bundle is valid
if ! git -C "$REPO_PATH" bundle verify "$BUNDLE_PATH" &>/dev/null; then
    echo "ERROR: Bundle verification failed, removing bad bundle"
    rm -f "$BUNDLE_PATH"
    exit 1
fi

NEW_SIZE=$(stat -f%z "$BUNDLE_PATH")
echo "Created ${BUNDLE_NAME} ($(( NEW_SIZE / 1024 )) KB)"

# Find the most recent previous backup (excluding the one we just made)
PREVIOUS=$(ls -t "${BACKUP_DEST}/${REPO_NAME}"-*.bundle 2>/dev/null | grep -v "$BUNDLE_NAME" | head -1 || true)

if [[ -n "$PREVIOUS" ]]; then
    PREV_SIZE=$(stat -f%z "$PREVIOUS")
    if [[ "$NEW_SIZE" -lt "$PREV_SIZE" ]]; then
        DIFF=$(( PREV_SIZE - NEW_SIZE ))
        echo "ERROR: New backup is smaller than previous by $(( DIFF / 1024 )) KB"
        echo "  Previous: $(basename "$PREVIOUS") ($(( PREV_SIZE / 1024 )) KB)"
        echo "  New:      ${BUNDLE_NAME} ($(( NEW_SIZE / 1024 )) KB)"
        echo "Removing new backup, keeping existing backups intact."
        rm -f "$BUNDLE_PATH"
        exit 1
    fi
fi

# Rotate: remove oldest backups beyond MAX_BACKUPS
BACKUPS=($(ls -t "${BACKUP_DEST}/${REPO_NAME}"-*.bundle 2>/dev/null))
if [[ ${#BACKUPS[@]} -gt $MAX_BACKUPS ]]; then
    for OLD in "${BACKUPS[@]:$MAX_BACKUPS}"; do
        echo "Rotating out: $(basename "$OLD")"
        rm -f "$OLD"
    done
fi

REMAINING=($(ls -t "${BACKUP_DEST}/${REPO_NAME}"-*.bundle 2>/dev/null))
echo "Done. ${#REMAINING[@]} backup(s) retained for ${REPO_NAME}."
