#! /usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function source_all() {
    # ${1}: The directory to source all the files from.

    if [[ -d "${1}" ]]; then
      for file in "${1}"/*; do
        [[ -f "$file" ]] && source "$file"
      done
    fi
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
        src::draw_banner

        echo -e "n1 by ${cyan}${italic}${bold}@hudsonsmith${reset}"
        echo ""
        echo "set [theme] # Loads a theme"
        echo "list        # Lists all themes"
        echo "update      # Fetch new prompts and get new version changes."
    else
        case "${1}" in
            init)
                src::init
                ;;

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

            update)
                [[ -f ~/.n1/install.sh ]] && ~/.n1/install.sh
                ;;
            
            *)
                echo "Error: Command not found"
                ;;
        esac
    fi
}

main "$@"
