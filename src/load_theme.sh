#! /usr/bin/env bash

function src::load_theme() {
    if [[ "$#" < 2 ]]; then
        echo "Missing file name."
        exit 1
    fi

    if [[ -f "./themes/${2}.sh" ]]; then
        cat ./themes/${2}.sh > ~/.omb.sh
        exit
    fi
}