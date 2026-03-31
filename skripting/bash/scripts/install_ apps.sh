#!/bin/bash

# ─── Exit on error, undefined vars, pipe failures ─────────────────────────
set -euo pipefail

# ─── Server-variables ────────────────────────────────────────────────────────
ip=$(hostname -I | awk '{print $1}')
host=$(hostname --short)
fqdn=$(hostname --fqdn)
email=""
sshport=""

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

check_server_variables() {   
        while true; do
            printf "\e[1;34m"
            printf "**************************************** \n"
            printf "        🚀  SERVER VARIABLES  🚀         \n"
            printf "**************************************** \n"
            printf "1) IP:\t\t %s \n" "$ip"
            printf "2) HOST:\t %s \n" "$host"
            printf "3) FQDN:\t %s \n" "$fqdn"
            printf "4) E-MAIL:\t %s \n" "$email"
            printf "5) SSH-PORT:\t %s \n" "$sshport"
            printf "6) Proceed \n"
            printf "7) Start Over \n"
            printf "**************************************** \n"
            
            read -rp " Your choice [1-7]: " choice

            case $choice in
                1) read -rp " ENTER IP:       " ip ;;
                2) read -rp " ENTER HOST:     " host ;;
                3) read -rp " ENTER FQDN:     " fqdn ;;
                4) read -rp " ENTER EMAIL:    " email ;;
                5) read -rp " ENTER SSHPORT:  " sshport ;;
                6) break ;;
                7) check_server_variables; return ;;
                *) if_invalid ;;
            esac
        done

        printf "**************************************** \n"
        printf "\e[1;32m"
        printf "✅  Got all server variables \n"
}

backup_file() {
    local file="$1"

    if [ ! -f "$file" ]; then
        printf "\e[1;31m"
        printf "❌  File: %s not found \n" "$file"
        return 1
    elif [ -f "$file.$(date +%Y%m%d_%H%M%S).backup" ]; then
        printf "\e[1;33m"
        printf "⚠️  Backup: %s already exists \n" "$file"
        return 1
    else
        cp "$file" "$file.$(date +%Y%m%d_%H%M%S).backup"
        printf "\e[1;32m"
        printf "✅  Backup: %s created \n" "$file.$(date +%Y%m%d_%H%M%S).backup"
    fi
}

# ─── Apps ─────────────────────────────────────────────────────────────────
install_r() {
    local TO_INSTALL=( "build-essential" "ca-certificates" "curl" "dirmngr" "gfortran" "git" "libblas-dev" "libcairo2-dev" "libcurl4-openssl-dev" "libfontconfig1-dev" "libfreetype6-dev" "libfribidi-dev" "libgdal-dev" "libgeos-dev" "libgit2-dev" "libglpk-dev" "libgmp-dev" "libharfbuzz-dev" "libjpeg-dev" "liblapack-dev" "libpng-dev" "libproj-dev" "libreadline-dev" "libssl-dev" "libtbb-dev" "libtiff-dev" "libx11-dev" "libxml2-dev" "libxt-dev" "locales" "software-properties-common" "unzip" "wget" "r-base" "r-base-dev")

    # Adding CRAN repository
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | \
    gpg --dearmor | sudo tee /etc/apt/keyrings/cran.gpg > /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/cran.gpg] https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" | \
    sudo tee /etc/apt/sources.list.d/cran.list
    apt update && apt upgrade -y

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # English keyboard
    locale-gen en_US.UTF-8
    # German keyboard
    #locale-gen de_DE.UTF-8

    # Installing Quarto
    local file="/tmp/quarto-linux-amd64.deb"

    if wget -q -O "${file}" https://quarto.org/download/latest/quarto-linux-amd64.deb; then
        apt install -y "${file}"
        rm -f "${file}"

        printf "\e[1;32m"
        printf "✅  Installed. Quarto Version: %s \n" "$(quarto --version 2>/dev/null)"
    else
        printf "\e[1;31m"
        printf "❌  Quarto failed \n"
    fi

    # Installing R-Packages
    R_PACKAGES=(
        # Core data science
        "tidyverse" "data.table" "janitor" "lubridate" "glue" "here" "vroom"

        # Visualization
        "ggpubr" "cowplot" "patchwork" "corrplot" "plotly" "scales" "viridis" "RColorBrewer" "ggridges" "GGally" "hrbrthemes" 

        # Statistics
        "car" "psych" "Hmisc" "DescTools" "multcomp" "emmeans" "lmtest" "sandwich" "AER" "survival" "coxme" 

        # Mixed models
        "lme4" "nlme" "lmerTest" "glmmTMB" "pbkrtest" "performance" "parameters" "insight" 

        # Econometrics
        "plm" "fixest" "estimatr" "ivreg" "dynlm" "vars" "urca" "tsDyn" 

        # Machine learning
        "caret" "tidymodels" "randomForest" "ranger" "xgboost" "e1071" "gbm" "nnet" "kknn" "klaR" "mlr3" "mlr3learners" 

        # Bayesian
        "rstan" "brms" "cmdstanr" "bayesplot" "loo" "posterior" 

        # SEM
        "lavaan" "semTools" "semPlot" 

        # Time series
        "forecast" "tseries" "prophet" "tsibble" "fable" "fabletools" "zoo" "xts" 

        # Spatial
        "sf" "sp" "terra" "raster" "stars" "tmap" "leaflet" 

        # Networks
        "igraph" "ggraph" "tidygraph" 

        # Reporting
        "rmarkdown" "knitr" "bookdown" "tinytex" "markdown" "stargazer" "modelsummary" "gt" "kableExtra" 

        # Dashboards
        "shiny" "shinydashboard" "flexdashboard" "DT" 

        # Development
        "devtools" "remotes" "usethis" "roxygen2" "testthat" "pkgdown" 

        # Databases
        "arrow" "duckdb" "DBI" "RSQLite" "dbplyr" 

        # Workflow
        "targets" "drake" "renv" "workflowsets" 

        # Utilities
        "pacman" "cli" "fs" "progress" "sessioninfo" "uuid" "digest"
    )

    for pkg in "${R_PACKAGES[@]}"; do
        Rscript -e "if (!require('$pkg')) install.packages('$pkg', repos='https://cloud.r-project.org/')"
    done

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  R Version: %s \n" "$(R --version  2>/dev/null | head -n1 | awk '{print $3}')"
}

install_python() {
    local TO_INSTALL=( "build-essential" "ca-certificates" "cmake" "curl" "dirmngr" "g++" "gcc" "gfortran" "git" "libatlas-base-dev" "libblas-dev" "libbz2-dev" "libffi-dev" "libfreetype6-dev" "libhdf5-dev" "libjpeg-dev" "liblapack-dev" "liblzma-dev" "libncursesw5-dev" "libpng-dev" "libreadline-dev" "libsqlite3-dev" "libssl-dev" "make" "python3" "python3-dev" "python3-distutils" "python3-pip" "python3-venv" "software-properties-common" "unzip" "uuid-dev" "wget" "zlib1g-dev" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Upgrading pip
    python3 -m venv ~/venvs/ds
    source ~/venvs/ds/bin/activate
    pip install --upgrade pip setuptools wheel

    # Installing Python-Packages
    pip install \
    altair \
    arviz \
    beautifulsoup4 \
    black \
    bokeh \
    dash \
    datasets \
    fastparquet \
    flake8 \
    gensim \
    h5py \
    httpx \
    hypothesis \
    imageio \
    isort \
    lightgbm \
    loguru \
    lxml \
    matplotlib \
    mypy \
    networkx \
    nltk \
    numpy \
    opencv-python-headless \
    openpyxl \
    pandas \
    pillow \
    plotly \
    pre-commit \
    psycopg2-binary \
    pyarrow \
    pydantic \
    pylint \
    pymc \
    pymongo \
    pytest \
    pytest-cov \
    python-dotenv \
    requests \
    scikit-learn \
    scipy \
    scrapy \
    seaborn \
    spacy \
    sqlalchemy \
    statsmodels \
    sympy \
    tokenizers \
    tqdm \
    transformers \
    wordcloud \
    xgboost \
    xlrd \
    xlwt

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  Python Version: %s \n" "$(python3 --version | awk '{print $2}')"
}

install_rsync() {
    local TO_INSTALL=( "rsync" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  RSync Version: %s \n" "$(rsync --version  2>/dev/null | head -n1 | awk '{print $3}')"
}

install_git() {
    local TO_INSTALL=( "git" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  Git Version: %s \n" "$(git --version  | awk '{print $3}')"
}

install_vim() {
    local TO_INSTALL=( "vim" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  Vim Version: %s \n" "$(vim --version  | awk '{print $3}')"
}

install_tmux() {
    local TO_INSTALL=( "tmux" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  Tmux Version: %s \n" "$(tmux -V  | awk '{print $3}')"
}

install_logwatch(){
    local TO_INSTALL=( "logwatch" "libdate-manip-perl msmtp msmtp-mta mailutils" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Backup
    mkdir -p /etc/logwatch/conf
    local conf_file_1="/etc/logwatch/conf/logwatch.conf"
    local conf_file_2="/usr/share/logwatch/default.conf/html/header.html"
    local conf_file_3="/etc/msmtprc"
    backup_file "$conf_file_2"
    backup_file "$conf_file_3"

    # Configuration

# /etc/logwatch/conf/logwatch.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_1
# Local Logwatch configuration - overrides default settings
# Output destination: stdout , mail, or file
Output = mail

# Email recipient for reports when Output = mail
MailTo = admin@example.com

# Email sender address (requires valid MTA configuration)
MailFrom = logwatch@yourserver.example.com

# Mail transfer agent to use
mailer = "/usr/sbin/sendmail -t"

# Report detail level: Low, Med, High, or numeric 0-10
Detail = Med

# Default services to include: All, or a comma-separated list
Service = All

# Date range to analyze: Today, Yesterday, or custom range
Range = Yesterday

# Output format: text or html
Format = html

# Archive processing: Yes or No
Archives = No

# Log directory location (rarely needs changing)
LogDir = /var/log

# Temporary directory for processing
TmpDir = /var/cache/logwatch
EOF

# /usr/share/logwatch/default.conf/html/header.html — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_2
<!DOCTYPE html>
<html>
  <head>
    <title>Logwatch $Version ( $VDate )</title>
    <meta name="generator" content="Logwatch  $Version ( $VDate )" />
    <style type="text/css">
      body {
        font-size: 1rem;
      }
      h1 {
        color: gray;
        font-family: monospace, sans-serif;
      }
      h2 {
        font-family: monospace, sans-serif;
        margin: 0 0 0.25rem 0;
      }
      h3 {
        color: white;
        font-family: monospace, sans-serif;
      }
      table {
        display: table;
        border-spacing: 0;
        border: none;
      }
      th {
        border: none;
        text-align: left;
        font-family: monospace, sans-serif;
        padding: 0;
      }
      th h2 a {
        background: #348dbc;
        color: #fff;
        text-align: left;
        font-family: monospace, sans-serif;
        border-radius: 4px 4px 0 0;
        display: block;
        padding: 1.1rem;
      }
      td {
        background: #f4f4f4;
        border: none;
        border-bottom: 1px solid #ccc;
        text-align: left;
        padding: 0.35rem;
        font-family: monospace, sans-serif;
      }
      li {
        font-family: monospace, sans-serif;
      }
      .ref {
        padding-left: 1%;
      }
      .service {
        padding-left: 1%;
      }
      .return_link {
        border-top: 1px;
        border-bottom: 1px;
        padding: 1%;
        margin-top: 1%;
        margin-bottom: 1%;
        font-family: sans-serif;
      }
      .copyright {
        color: black;
        border-top: 1px solid grey;
        border-bottom: 1px solid grey;
        padding: 1%;
        margin-top: 1%;
        margin-bottom: 1%;
      }
    </style>
  </head>
  <body style="width: 90%; margin-left: 5%; margin-right: 5%" bgcolor="#FFFFFF" class="logwatch">
    <hr />
    <!-- End header.html -->
EOF

# /etc/ssmtp/ssmtp.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_3
# Set default values for all following accounts.
defaults

# Use the mail submission port 587 instead of the SMTP port 25.
port 587

# Always use TLS.
tls on

# Mail account
# TODO: Use your own mail address
account name@mydomain.com

# Host name of the SMTP server
# TODO: Use the host of your own mail account
host smtp.maildomain.com

# This is especially important for mail providers like 
# Ionos, 1&1, GMX and web.de
set_from_header on

# Envelope-from address
# TODO: Use your own mail address
from name@mydomain.com

# Authentication. The password is given using one of five methods, see below.
auth on

# TODO: Use your own user name for the mail account
user name@mydomain.com

# Password method 3: Store the password directly in this file. Usually it is not
# a good idea to store passwords in plain text files. If you do it anyway, at
# least make sure that this file can only be read by yourself.
# TODO: Use the password of your own mail account
password pAssW0Rd123

# Set a default account
# TODO: Use your own mail address
account default: name@mydomain.com

# Map local users to mail addresses (for crontab)
aliases /etc/aliases
EOF

    # Permissions
    chmod 644 $conf_file_1
    chmod 644 $conf_file_2
    chmod 600 $conf_file_3
    chown root:root $conf_file_3

    # Allow in firewall
    ufw allow 587

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  LogWatch Version: %s \n" "$(logwatch --version  | awk '{print $3}')"
}

install_clamav(){
    local TO_INSTALL=( "clamav" "clamav-daemon" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Services
    freshclam || true
    systemctl enable clamav-daemon --now

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  ClamAV Version: %s \n" "$(clamscan --version  | awk '{print $3}')"
}

# ─── Menu ─────────────────────────────────────────────────────────────────
if_invalid() {
    printf "\e[1;33m"
    printf "⚠️  Invalid response, try again: "
}

print_menu() {
    # App list
    local APPS=(
        "R"
        "Python"
        "RSync"
        "Git"
        "Vim"
        "Tmux"
        "logwatch"
        "ClamAV"
    )

    # App installer functions
    local INSTALL_CMDS=(
        "install_r"
        "install_python"
        "install_rsync"
        "install_git"
        "install_vim"
        "install_tmux"
        "install_logwatch"
        "install_clamav"
    )

    # Print menu
    printf "\e[1;34m"
    printf "**************************************** \n"
    printf "       🚀  APP INSTALLER v1.0  🚀        \n"
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
    check_server_variables
    print_menu

    printf "\e[1;34m"
    printf "**************************************** \n"
}

# ─── Initialize ───────────────────────────────────────────────────────────
start_main
