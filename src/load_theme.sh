#! /usr/bin/env bash

function src::load_theme() {
    # ${1} = THEME_DIR 
    # ${2} = THEME_NAME
    
    if [[ "$#" < 2 ]]; then
        echo "Usage: n1 set {theme}"
        exit 1
    fi

    if [[ -f "${1}/${2}.sh" ]]; then
        # Source the theme file.
        source ${1}/${2}.sh

        local bashrc_line=$(cat ~/.bashrc | grep "n1 set")

        if [[ ! "n1 set ${2}" == "${bashrc_line}" ]]; then
            sed -i "s/${bashrc_line}/n1 set ${2}/" ~/.bashrc
        fi
    else
        echo "${2}: Theme not found"
    fi
}
