#! /usr/bin/env bash

if [[ -f "$(pwd)/src/db.sh" ]]; then
    source "$(pwd)/src/db.sh"

elif [[ -f ~/.n1/src/db.sh ]]; then
    source ~/.n1/src/db.sh
fi

function src::init () {
    echo "[DEBUG] src::init has been called"

    if [[ -f "${HOME}/.n1/n1.conf" ]]; then
        src::db::connect "${HOME}/.n1/n1.conf"
        echo "[INIT] set: ~/.n1/n1.conf"

    elif [[ -f ./n1.conf ]]; then
        src::db::connect "./n1.conf"
        echo "[INIT] set: ./n1.conf"

    else
        echo "[ERROR] No config file found!"
    fi

    echo "Querying db!"
    local current_prompt=$(src::db::get prompt)
    src::db::visualize_db
    src::load_theme "${THEME_DIR}" "${current_prompt}"
}
