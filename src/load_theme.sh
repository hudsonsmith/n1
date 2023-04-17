#! /usr/bin/env bash

function src::load_theme() {
    # ${1} = THEME_DIR 
    # ${2} = THEME_NAME
    
    if [[ "$#" < 2 ]]; then
        echo "Usage: omb set {theme}"
        exit 1
    fi

    if [[ -f "${1}/${2}.sh" ]]; then
        # Source the theme file.
        source ${1}/${2}.sh
    
    else
        echo "${2}: Theme not found"
    fi
}