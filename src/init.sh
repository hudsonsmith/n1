#! /usr/bin/env bash

function src::init () {
    local path=""
    if [[ -f "${HOME}/.n1/n1.conf" ]]; then
        path="${HOME}/.n1/n1.conf"

    elif [[ -f ./n1.conf ]]; then
        path="./n1.conf"

    else
        echo "[ERROR] No config file found!"
        exit
    fi

    src::load_theme "${THEME_DIR}" "$(cat "${path}")"
}
