#!/bin/bash

# ─── Exit on error, undefined vars, pipe failures ─────────────────────────
set -euo pipefail

# ─── Helper ───────────────────────────────────────────────────────────────
check_root(){
    if [[ $EUID -eq 0 ]]; then
        printf "\e[1;32m"
        printf "✅  You have root \n"
    else
        printf "\e[1;31m"
        printf "❌  You have no root \n"
        exit 1
    fi
}

install_upgrade() {
    local TO_INSTALL=( "update" "upgrade" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi
}

install_full-upgrade() {
    local TO_INSTALL=( "update" "full-upgrade" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi
} 

clean_disk() {
    printf "\e[1;33m"
    printf "⚠️  Disk space (before): \n"
    printf "**************************************** \n"
    free -h

    # Clean apt cache
    apt clean -y -qq
    # Remove obsolete packages
    apt autoclean -y -qq
    # Remove unused packages
    apt autoremove -y -qq
    # Remove Thumbnail Cache
    for dir in /home/*/.cache/thumbnails /root/.cache/thumbnails; do
        rm -rf "${dir:?}"/*
    done
    # Empty trash
    rm -rf /home/*/.local/share/Trash/{files,info}/*
    rm -rf /root/.local/share/Trash/{files,info}/*
    # Remove Log files older 90 days
    find /var/log/ -type f -name "*.gz" -mtime +90 -exec rm -f {} +

    printf "\e[1;32m"
    printf "✅  Disk space (now): \n"
    printf "**************************************** \n"
    free -h
}

# ─── Menu ─────────────────────────────────────────────────────────────────
if_invalid() {
    printf "\e[1;33m"
    printf "⚠️  Invalid response, try again: "
}

print_menu() {
    # App list
    local APPS=(
        "upgrade"
        "full-upgrade"
    )

    # App installer functions
    local INSTALL_CMDS=(
        "install_upgrade"
        "install_full-upgrade"
    )

    # Print menu
    printf "\e[1;34m"
    printf "**************************************** \n"
    printf "      🚀  UPDATE INSTALLER v1.0  🚀      \n"
    printf "**************************************** \n"

    for i in "${!APPS[@]}"; do
        printf "%2d) %s \n" $((i+1)) "${APPS[$i]}"
    done

    # Read user selection
    read -rp " Your selection: " -a SELECTIONS
    printf "**************************************** \n"
    SELECTED_CMDS=()

    # Validate selections
    for choice in "${SELECTIONS[@]}"; do
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#APPS[@]} )); then
            index=$((choice-1))
            SELECTED_CMDS+=("${INSTALL_CMDS[$index]}")
        else
            printf "\e[1;33m"
            printf "⚠️  Invalid choice: %s \n" "$choice"
        fi
    done

    # Run installers
    for cmd in "${SELECTED_CMDS[@]}"; do
        eval "$cmd"
    done
}

# ─── Main ─────────────────────────────────────────────────────────────────
start_main() {
    clear

    printf "\e[1;34m"
    printf "**************************************** \n"

    check_root
    print_menu
    clean_disk

    printf "\e[1;34m"
    printf "**************************************** \n"
}

# ─── Initialize ───────────────────────────────────────────────────────────
start_main
