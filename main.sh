#! /usr/bin/env bash

# Source the entire library.
source ./src/*

function main() {
    case "$1" in
        set)
            src::load_theme "$@"
            ;;
        
        *)
            echo "Error: Command not found"
    esac
}

main "$@"