#! /usr/bin/env bash

if [[ -f "$(pwd)/src/db.sh" ]]; then
    source "$(pwd)/src/db.sh"

elif [[ -f ~/.n1/src/db.sh ]]; then
    source ~/.n1/src/db.sh
fi

function src::load_theme() {
    # ${1} = THEME_DIR 
    # ${2} = THEME_NAME
    
    if [[ "$#" < 2 ]]; then
        echo "Usage: n1 set {theme}"
        exit 1
    fi

    if [[ -f "${1}/${2}.sh" ]]; then
        # Source the theme file.
        source "${1}/${2}.sh"

        if [[ -f "~/.n1/n1.conf" ]]; then
            src::db::connect "~/.n1/n1.conf"

        elif [[ -f "./n1.conf" ]]; then
            src::db::connect "./n1.conf"
        fi

        src::db::set "prompt" "${2}"
        src::db::save

    else
        echo "${2}: Theme not found"
    fi
}


