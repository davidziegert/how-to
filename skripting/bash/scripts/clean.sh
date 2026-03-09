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
    echo -e "########################## \n"
    free -h
    echo -e "########################## \n"

    # Clean apt cache
    apt clean -y -qq
    apt -s clean -y -qq
    apt clean all -y -qq
    echo -e "${OK} APT CLEAN ############## \n"

    # Remove obsolete packages
    apt autoclean -y -qq
    echo -e "${OK} AUTOCLEAN ############## \n"

    # Remove unused packages
    apt autoremove -y -qq
    echo -e "${OK} AUTOREMOVE ############# \n"










    # Remove Log files older 60 days
    find /var/log/ -type f -name "*.gz" -mtime +60 rm -f {} +
    echo -e "${OK} LOG CLEAN ############## \n"

    # Remove Thumbnail Cache
    rm -rf ~/.cache/thumbnails/*
    echo -e "${OK} THUMBS CACHE CLEAN ##### \n"

    # Empty trash
    rm -rf /home/*/.local/share/Trash/*/**
    rm -rf /root/.local/share/Trash/*/**
    echo -e "${OK} TRASH CLEAN ############ \n"



























    echo -e "########################## \n"
    free -h
    echo -e "########################## \n"
}

# ──────────────────────────────────────────────
#  Initialize
# ──────────────────────────────────────────────
check_root
do_clean