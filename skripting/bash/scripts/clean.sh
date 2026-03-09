#!/bin/bash

# ──────────────────────────────────────────────
#  Symbols
# ──────────────────────────────────────────────
OK=$'\u2714'
FAIL=$'\u2715'

# ──────────────────────────────────────────────
#  Check for root privileges (exit if missing)
# ──────────────────────────────────────────────
check_root() {
    if [[ $EUID -eq 0 ]]; then
        echo -e "${OK} HAS ROOT ############### \n"
    else
        echo -e "${FAIL} HAS NO ROOT ########## \n"
        exit 1
    fi
}

# ──────────────────────────────────────────────
#  Clean the host
# ──────────────────────────────────────────────
do_clean() {
    echo -e "######### MEMORY ######### \n"
    free -h
    echo -e "\n"
    echo -e "########################## \n"

    # Clean apt cache
    apt clean
    echo -e "${OK} APT CLEAN ############## \n"

    # Remove obsolete packages
    apt autoclean -y -qq
    echo -e "${OK} AUTOCLEAN ############## \n"

    # Remove unused packages
    apt autoremove -y -qq
    echo -e "\n"
    echo -e "${OK} AUTOREMOVE ############# \n"

    # Remove Thumbnail Cache
    for dir in /home/*/.cache/thumbnails /root/.cache/thumbnails; do
        rm -rf "${dir:?}"/*
    done
    echo -e "${OK} THUMBS CACHE CLEAN ##### \n"

    # Empty trash
    rm -rf /home/*/.local/share/Trash/{files,info}/*
    rm -rf /root/.local/share/Trash/{files,info}/*
    echo -e "${OK} TRASH CLEAN ############ \n"

    # Remove Log files older 90 days
    find /var/log/ -type f -name "*.gz" -mtime +90 -exec rm -f {} +
    echo -e "${OK} LOG CLEAN ############## \n"

    echo -e "######### MEMORY ######### \n"
    free -h
    echo -e "\n"
    echo -e "########################## \n"
}

# ──────────────────────────────────────────────
#  Initialize
# ──────────────────────────────────────────────
check_root
do_clean