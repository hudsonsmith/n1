#! /usr/bin/env bash

[[ -f "./src/db.sh" ]] && source ./src/db.sh
    \ || [[ -f "~/.n1/src/db.sh" ]] && source ~/.n1/src/db.sh

function src::init () {
    if [[ -f "~/.n1/n1.conf" ]]; then
        db::connect "~/.n1/n1.conf"

    elif [[ -f "./n1.conf" ]]; then
        db::connect "./n1.conf"
    fi

    local current_prompt=$(src::db::get prompt)
    src::load_theme "${current_prompt}"
}
