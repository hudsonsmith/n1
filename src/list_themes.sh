#! /usr/bin/env bash

function src::list_themes() {
    # ${1}: The directory with all the themes.

    # Validate input
    if [[ ! -d "${1}" ]]; then
        echo "Error: Directory '${1}' does not exist." >&2
        return 1
    fi

    # Draw a <hr> line across
    local last_ps1="${PS1}"
    local theme_count
    theme_count=$(find "${1}" -type f | wc -l)

    for file in "${1}"/*; do
        [[ -f "$file" ]] || continue

        source "$file" || {
            echo "Error: Failed to source ${file}" >&2
            continue
        }

        src::draw_hr
        echo ""
        echo -e "${green}${bold}${italic}$(basename "$file")${reset}"
        echo -e "${preview}"
        echo ""
    done

    src::draw_hr
    echo ""
    echo "Loaded ${theme_count} themes."

    PS1="${last_ps1}"
}

