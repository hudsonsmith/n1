#! /usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "${SCRIPT_DIR}"

function source_all() {
    # ${1}: The directory to source all the files from.

    for file in $(ls "${1}"); do
        source "${1}/${file}"
    done
}

# Dynamically load the libs even if in dev mode.
if [[ "${SCRIPT_DIR}" == "${HOME}/.omb" ]]; then
    echo "Real Mode"
    # Source the entire library.
    source_all ~/.omb/src
    THEME_DIR="$HOME/.omb/themes"
else
    echo "Dev mode"
    source_all ./src
    THEME_DIR="./themes"
fi

function main() {
    if (( $# <= 0 )); then
        echo "Error: No arguments provided"
    else
        case "${1}" in
            set)
                # Pass the theme dir and the name of the script to the api.
                src::load_theme "${THEME_DIR}" "${2}"
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
