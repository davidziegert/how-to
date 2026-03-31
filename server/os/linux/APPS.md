# Linux (Ubuntu)

## Applications

### R

```bash
sudo apt install -y build-essential ca-certificates curl dirmngr gfortran git libblas-dev libcairo2-dev libcurl4-openssl-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev libgdal-dev libgeos-dev libgit2-dev libglpk-dev libgmp-dev libharfbuzz-dev libjpeg-dev liblapack-dev libpng-dev libproj-dev libreadline-dev libssl-dev libtbb-dev libtiff-dev libx11-dev libxml2-dev libxt-dev locales software-properties-common unzip wget
```

```bash
# English keyboard
sudo locale-gen en_US.UTF-8
# German keyboard
sudo locale-gen de_DE.UTF-8
```

```bash
sudo mkdir -p /etc/apt/keyrings
sudo curl -fsSL https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | \
gpg --dearmor | sudo tee /etc/apt/keyrings/cran.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/cran.gpg] https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" | \
sudo tee /etc/apt/sources.list.d/cran.list
sudo apt update -y
sudo apt upgrade -y
```

```bash
sudo apt install -y r-base r-base-dev
sudo R --version
```

```bash
sudo wget -q https://quarto.org/download/latest/quarto-linux-amd64.deb
sudo apt install -y ./quarto-linux-amd64.deb
sudo rm ./quarto-linux-amd64.deb
```

```bash
install.packages(c(
    # Core data science
    "tidyverse", "data.table", "janitor", "lubridate", "glue", "here", "vroom",

    # Visualization
    "ggpubr", "cowplot", "patchwork", "corrplot", "plotly", "scales", "viridis", "RColorBrewer", "ggridges", "GGally", "hrbrthemes",

    # Statistics
    "car", "psych", "Hmisc", "DescTools", "multcomp", "emmeans", "lmtest", "sandwich", "AER", "survival", "coxme",

    # Mixed models
    "lme4", "nlme", "lmerTest", "glmmTMB", "pbkrtest", "performance", "parameters", "insight",

    # Econometrics
    "plm", "fixest", "estimatr", "ivreg", "dynlm", "vars", "urca", "tsDyn",

    # Machine learning
    "caret", "tidymodels", "randomForest", "ranger", "xgboost", "e1071", "gbm", "nnet", "kknn", "klaR", "mlr3", "mlr3learners", 

    # Bayesian
    "rstan", "brms", "cmdstanr", "bayesplot", "loo", "posterior",

    # SEM
    "lavaan", "semTools", "semPlot",

    # Time series
    "forecast", "tseries", "prophet", "tsibble", "fable", "fabletools", "zoo", "xts",

    # Spatial
    "sf", "sp", "terra", "raster", "stars", "tmap", "leaflet",

    # Networks
    "igraph", "ggraph", "tidygraph",

    # Reporting
    "rmarkdown", "knitr", "bookdown", "tinytex", "markdown", "stargazer", "modelsummary", "gt", "kableExtra",

    # Dashboards
    "shiny", "shinydashboard", "flexdashboard", "DT",

    # Development
    "devtools", "remotes", "usethis", "roxygen2", "testthat", "pkgdown",

    # Databases
    "arrow", "duckdb", "DBI", "RSQLite", "dbplyr",

    # Workflow
    "targets", "drake", "renv", "workflowsets",

    # Utilities
    "pacman", "cli", "fs", "progress", "sessioninfo", "uuid", "digest"
), repos = "https://cloud.r-project.org")
```

### Python

```bash
sudo apt install -y build-essential ca-certificates cmake curl dirmngr g++ gcc gfortran git libatlas-base-dev libblas-dev libbz2-dev libffi-dev libfreetype6-dev libhdf5-dev libjpeg-dev liblapack-dev liblzma-dev libncursesw5-dev libpng-dev libreadline-dev libsqlite3-dev libssl-dev make software-properties-common unzip uuid-dev wget zlib1g-dev
```

```bash
sudo apt install -y python3 python3-dev python3-distutils python3-pip python3-venv
sudo python3 --version
```

```bash
python3 -m venv ~/venvs/ds
source ~/venvs/ds/bin/activate
pip install --upgrade pip setuptools wheel
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
```

### RSync

```bash
sudo apt install -y rsync
sudo rsync --version
```

### Git

```bash
sudo apt install -y git
sudo git --version
```

### Vim

```bash
sudo apt install -y vim
sudo vim --version
```

### Tmux

```bash
sudo apt install -y tmux
sudo tmux -V
```

### logwatch

```bash
sudo apt install -y logwatch libdate-manip-perl msmtp msmtp-mta mailutils
```

```bash
sudo mkdir -p /etc/logwatch/conf
sudo cp /usr/share/logwatch/default.conf/logwatch.conf /etc/logwatch/conf/logwatch.conf
sudo chmod 644 /etc/logwatch/conf/logwatch.conf
sudo nano /etc/logwatch/conf/logwatch.conf
```

```
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
```

```bash
sudo cp /usr/share/logwatch/default.conf/html/header.html /usr/share/logwatch/default.conf/html/header.html.$(date +%Y%m%d_%H%M%S).backup
sudo chmod 644 /usr/share/logwatch/default.conf/html/header.html
sudo nano /usr/share/logwatch/default.conf/html/header.html
```

```
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
```

```bash
sudo cp /etc/msmtprc /etc/msmtprc.$(date +%Y%m%d_%H%M%S).backup
sudo chmod 600 /etc/msmtprc
sudo chown root:root /etc/msmtprc
sudo nano /etc/msmtprc
```

```
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
```

```bash
ufw allow 587
logwatch --version
```

### ClamAV

```bash
sudo apt install -y clamav clamav-daemon
sudo clamscan --version
sudo freshclam || true
sudo systemctl enable clamav-daemon --now
sudo systemctl status clamav-daemon
```