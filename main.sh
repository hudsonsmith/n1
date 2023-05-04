#! /usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function source_all() {
    # ${1}: The directory to source all the files from.

    for file in $(ls "${1}"); do
        source "${1}/${file}"
    done
}

# Dynamically load the libs even if in dev mode.
if [[ "${SCRIPT_DIR}" == "${HOME}/.n1" ]]; then
    # REAL MODE
    # Source the entire library.
    source_all ~/.n1/src
    source_all ~/.n1/prompt_tools

    THEME_DIR="$HOME/.n1/themes"
else
    # DEV MODE
    source_all ./src
    source_all ./prompt_tools

    THEME_DIR="./themes"
fi

function main() {
    if (( $# <= 0 )); then
        draw_banner

        echo "Error: No arguments provided"
        echo ""
        echo "set [theme] # Loads a theme"
        echo "list        # Lists all themes"
    else
        case "${1}" in
            set)
                # Pass the theme dir and the name of the script to the api.
                if [[ -z "${2}" ]]; then
                    echo "Error: No theme provided"
                else
                    src::load_theme "${THEME_DIR}" "${2}"
                fi
                ;;
            
            list)
                src::list_themes "${THEME_DIR}"
                ;;
            
            *)
                echo "Error: Command not found"
                ;;
        esac
    fi
}

main "$@"
