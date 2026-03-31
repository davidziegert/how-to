#!/bin/bash

# ─── Exit on error, undefined vars, pipe failures ─────────────────────────
set -euo pipefail

# ─── USER ────────────────────────────────────────────────────────────────────
first_name=""
last_name=""
user_mail=""
user_name=""
user_password=""

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

check_uservars() {
	if [ -z "$first_name" ] || [ -z "$last_name" ] || [ -z "$user_mail" ] || [ -z "$user_name" ] || [ -z "$user_password" ]; then
        edit_uservars;
		exit 1
	fi
}

edit_uservars() {
    read -rp " ENTER first_name:    " first_name
    read -rp " ENTER last_name:     " last_name
    read -rp " ENTER user_mail:     " user_mail
    read -rp " ENTER user_name:     " user_name
    read -rp " ENTER user_password: " user_password
    echo
}

add_user() {
    local ldap_uri="ldaps://ldap.example.com"
    local ldap_base_dn="dc=example,dc=com"
    local ldap_admin_dn="cn=admin,dc=example,dc=com"
    local ldap_admin_password="NEW_user_password"
    local default_group="users"
    local home_dir="/home"
    local user_cn="$first_name $last_name"
    local user_home="$home_dir/$user_name"
    local user_uid=""
    local user_gid=""
    local hashed_password=""

    # Check if user exists
    if ldapsearch -x -D "$ldap_admin_dn" -w "$ldap_admin_password" -H "$ldap_uri" -b "ou=People,$ldap_base_dn" "(uid=$user_name)" | grep -q "dn:"; then
        printf "\e[1;31m"
        printf "❌  User: %s already exists. \n" "${user_name}"
        exit 1
    fi

    # Generate UID/GID
    user_uid=$(($(ldapsearch -x -D "$ldap_admin_dn" -w "$ldap_admin_password" -H "$ldap_uri" -b "ou=People,$ldap_base_dn" "(objectClass=posixAccount)" uidNumber | grep uidNumber | wc -l) + 1000))
    user_gid=$(ldapsearch -x -D "$ldap_admin_dn" -w "$ldap_admin_password" -H "$ldap_uri" -b "ou=Groups,$ldap_base_dn" "(cn=$default_group)" gidNumber | grep gidNumber | awk '{print $2}')

    # Fallback if group not found
    if [ -z "$user_gid" ]; then
        printf "\e[1;31m"
        printf "❌  Group: %s not found. Using GID 1000 \n" "${default_group}"
        user_gid=1000
    fi

    # Create home dir
    mkdir -p "$user_home"
    chmod 700 "$user_home"

    # Hash user_password
    hashed_password=$(slappasswd -s "$user_password")

# Create tmp ldif
cat <<EOF > /tmp/add_user.ldif
dn: uid=$user_name,ou=People,$ldap_base_dn
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
cn: $user_cn
sn: $last_name
givenName: $first_name
mail: $user_mail
uid: $user_name
uidNumber: $user_uid
gidNumber: $user_gid
homeDirectory: $user_home
loginShell: /bin/bash
useruser_password: $hashed_password
EOF

    # Add user to LDAP via tmp ldif
    ldapadd -x -D "$ldap_admin_dn" -w "$ldap_admin_password" -H "$ldap_uri" -f /tmp/add_user.ldif

    # Add user to SAMBA
    (echo "$user_password"; echo "$user_password") | smbpasswd -a -s "$user_name"

    # Set folder permissions
    chown "$user_name:$default_group" "$user_home"

    printf "\e[1;32m"
    printf "✅  Success! \n"
    printf "✅  User: %s \n" "${user_name}"
    printf "✅  LDAP DN: %s \n" "${UID=$user_name,OU=PEOPLE,$ldap_base_dn}"
    printf "✅  Home Dir: %s \n" "${user_home}"
    printf "✅  DEfault Group: %s \n" "${default_group}"
}

# ─── Menu ─────────────────────────────────────────────────────────────────
print_menu() {
    # Print menu
    printf "\e[1;34m"
    printf "**************************************** \n"
    printf "          🚀  LDAP USER v1.0  🚀         \n"
    printf "**************************************** \n"

    check_uservars
    add_user
}

# ─── Main ─────────────────────────────────────────────────────────────────
start_main() {
    clear

    printf "\e[1;34m"
    printf "**************************************** \n"

    check_root
    print_menu

    printf "\e[1;34m"
    printf "**************************************** \n"
}

# ─── Initialize ───────────────────────────────────────────────────────────
start_main