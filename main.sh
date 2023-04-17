#! /usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Dynamically load the libs even if in dev mode.
if [[ "${SCRIPT_DIR}" == "${HOME}/bin" ]]; then
    # Source the entire library.
    source ~/omb/src/*
    THEME_DIR="~/omb/themes"
else
    source ./src/*
    THEME_DIR="./themes"
fi

function main() {
    if (( $# <= 0 )); then
        echo "Error: No arguments provided"
        exit 1
    fi

    case "$1" in
        set)
            # Pass the theme dir and the name of the script to the api.
            src::load_theme "${THEME_DIR}" "${2}"
            ;;
        
        *)
            echo "Error: Command not found"
            exit 1
            ;;
    esac
}

main "$@"