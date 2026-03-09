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
#  Update the host
# ──────────────────────────────────────────────
do_update() {
    apt update -y -qq
    echo -e "${OK} UPDATE ################# \n"

    while true; do
        read -rp "Do you want to full-upgrade? (y/n): " yn
        case "${yn}" in
            [yY])
                apt full-upgrade
                echo -e "${OK} FULL-UPGRADE ########### \n"
                break
                ;;
            [nN])
                apt upgrade -y -qq
                echo -e "${OK} UPGRADE ################ \n"
                break
                ;;
            *)
                echo -e "${FAIL} INVALID RESPONSE — please enter y or n\n"
                ;;
        esac
    done
}

# ──────────────────────────────────────────────
#  Initialize
# ──────────────────────────────────────────────
check_root
do_update