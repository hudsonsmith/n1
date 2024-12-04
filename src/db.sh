#! /bin/env bash

CURRENT_DB=""
declare -A DB_DATA

# Connect to the database file and parse its contents
function src::db::connect ()
{
    if [[ -z "${1}" ]]; then
        echo "db.connect, no database name provided."
        return 1
    fi

    local path="${1}"
    if [[ -f "${path}" ]]; then
        CURRENT_DB="${path}"
        src::db::parse_db
    else
        echo "db.connect, database file doesn't exist."
        return 1
    fi
}

# Parse the database file into the DB_DATA associative array
function src::db::parse_db ()
{
    if [[ -z "${CURRENT_DB}" || ! -f "${CURRENT_DB}" ]]; then
        echo "db.parse_db, invalid or unset CURRENT_DB."
        return 1
    fi

    # Clear the existing DB_DATA array to prevent leftover entries
    DB_DATA=()

    # Read the database file line by line
    while read -r line; do
        # Trim leading and trailing spaces
        line=$(echo "$line" | xargs)

        # Skip empty lines or lines without an '=' character
        [[ "$line" == *"="* ]] && DB_DATA["${line%%=*}"]="${line#*=}"
    done < "${CURRENT_DB}"

    echo "db.parse_db, successfully parsed database: ${CURRENT_DB}"
}



# Visualize the database contents
function src::db::visualize_db ()
{
    for key in "${!DB_DATA[@]}"; do
        local val="${DB_DATA[$key]}"
        echo -e "\e[31m$key : $val\e[31;0m"
    done
}

# Set a key-value pair in the DB_DATA array
function src::db::set ()
{
    if (( $# < 2 )); then
        echo "db.set, not enough params provided."
        return 1
    fi

    echo "Key name: ${1}"
    echo "Theme name: ${2}"
    DB_DATA["$1"]="$2"
}

function src::db::save ()
{
    if [[ -z "${CURRENT_DB}" || ! -f "${CURRENT_DB}" ]]; then
        echo "db.save, invalid or unset CURRENT_DB."
        return 1
    fi

    # Clear the database file before saving
    > "${CURRENT_DB}"

    for key in "${!DB_DATA[@]}"; do
        # Retrieve the value for the current key
        local val="${DB_DATA[$key]}"
        echo "KEY: ${key}"
        echo "VALUE: ${val}"

        # Ensure neither key nor value is empty
        if [[ -n "${key}" && -n "${val}" ]]; then
            echo "${key}=${val}" >> "${CURRENT_DB}"
        fi
    done
}

# Get the value associated with a key from the DB_DATA array
function src::db::get ()
{
    if [[ -z "${1}" ]]; then
        echo "db.get, no key provided."
        return 1
    fi

    echo "${DB_DATA[$1]}"
}


