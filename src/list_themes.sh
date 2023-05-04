#! /usr/bin/env bash


function src::list_themes() {
    # ${1}: The directory with all the themes.

    # Draw a <hr> line across
    local last_ps1="${PS1}"
    local theme_count=$(/usr/bin/env ls "${1}" | wc -l)

    for file in $(ls ${1}); do
        source ${1}/${file}

        src::draw_hr
        echo ""
        echo -e "${green}${bold}${italic}${file}${reset}"
        echo -e "${preview}"
        echo ""
    done

    src::draw_hr
    echo ""
    echo "Loaded ${theme_count} themes."

    PS1="${last_ps1}"
}