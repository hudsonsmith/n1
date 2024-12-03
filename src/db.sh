#! /bin/env bash

CURRENT_DB=$false
declare -A DB_DATA


function src::db::connect ()
{
    # A function to set the current_db global var.
    if [[ -z "${1}" ]]; then
        echo "db.connect, no database name provided."
        exit
    else
        # Create a local path for checking.
        local path="$(pwd)/${1}"

        # If the path exists, set the current db to be that.
        if [[ -f "${path}" ]]; then
            CURRENT_DB=${path}
            db.parse_db
        else
            echo "db.connect, database file doesn't exist."
            exit
        fi
    fi
}


function src::db::parse_db ()
{
    local current_type=0
    local current_key_buffer=""

    for type in `cat ${CURRENT_DB}`; do
        if [[ $current_type == 0 ]]; then
            current_key_buffer="${type}"
            let "current_type += 1"
        else
            DB_DATA["${current_key_buffer}"]="${type}"
            let "current_type = 0"
        fi
    done
}


function src::db::visualize_db ()
{
    for key in "${!DB_DATA[@]}"; do
        local val=${DB_DATA[$key]}

        echo -e "\e[31m$key : $val\e[31;0m"
    done
}


function src::db::set ()
{
    if [[ $@ < 2 ]]; then
        echo "db.set, not enough params provided."
        exit
    fi

    DB_DATA[$1]=$2
}


function src::db::save ()
{
    # Clear the database.
    echo "" > "${CURRENT_DB}"

    for key in "${!DB_DATA[@]}"; do
        local val=${DB_DATA[$key]}

        echo "${key} ${val}" >> "${CURRENT_DB}"
    done
}


function src::db::get ()
{
    if [[ -z "${1}" ]]; then
        echo "db.get, no key provided."
        exit
    fi

    echo "${DB_DATA[$1]}"
}
