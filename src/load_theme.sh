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
        source "${1}/${2}.sh"

        local bashrc_line=$(grep "n1 set" ~/.bashrc)

        if [[ ! "n1 set ${2}" == "${bashrc_line}" ]]; then
            # Escape special characters in bashrc_line for use with sed
            local escaped_bashrc_line=$(printf '%s\n' "$bashrc_line" | sed 's/[&/\]/\\&/g')
            sed -i "s/${escaped_bashrc_line}/n1 set ${2}/" ~/.bashrc
        fi
    else
        echo "${2}: Theme not found"
    fi
}


