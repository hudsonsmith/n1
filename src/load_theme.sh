#! /usr/bin/env bash

[[ -f "./src/db.sh" ]] && source ./src/db.sh || [[ -f ~/.n1/src/db.sh ]] && source ~/.n1/src/db.sh

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
            db::connect "~/.n1/n1.conf"

        elif [[ -f "./n1.conf" ]]; then
            db::connect "./n1.conf"
        fi

        src::db::set prompt "${THEME_NAME}"
        src::db:save

    else
        echo "${2}: Theme not found"
    fi
}


