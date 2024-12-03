#!/usr/bin/env bash

INSTALLED_PATH="$HOME/.n1"
INSTALLED_PROGRAM="${INSTALLED_PATH}/n1"

function setup() {
    [[ -d "/tmp/oh_my_bash/" ]] && rm -rf /tmp/oh_my_bash/

    git clone https://github.com/hudsonsmith/oh_my_bash.git /tmp/oh_my_bash
    cd /tmp/oh_my_bash

    for file in ./installer_utils/*.sh; do
        [[ -f "$file" ]] && source "$file"
    done
}

function copy_files() {
    echo "Installed Path: ${INSTALLED_PATH}"
    touch ~/.bashrc

    util::alert "Creating directories..."

    mkdir -p "${INSTALLED_PATH}"
    cp main.sh "${INSTALLED_PATH}/n1"

    mkdir -p "${INSTALLED_PATH}/themes"
    cp themes/* "${INSTALLED_PATH}/themes/"

    mkdir -p "${INSTALLED_PATH}/src"
    cp src/* "${INSTALLED_PATH}/src"

    mkdir -p "${INSTALLED_PATH}/prompt_tools"
    cp prompt_tools/* "${INSTALLED_PATH}/prompt_tools/"

    alias_text="alias n1='source ${INSTALLED_PATH}/n1'"
    if ! grep -Fxq "${alias_text}" ~/.bashrc; then
        util::alert "Adding alias to ~/.bashrc"
        echo "${alias_text}" >> ~/.bashrc
    else
        util::alert "Alias already exists"
    fi

    if ! grep -Fxq "n1 set arrow" ~/.bashrc; then
        util::alert "Adding default theme"
        echo "n1 set arrow" >> ~/.bashrc
    else
        util::alert "Default theme already set"
    fi
}

function cleanup() {
    rm -rf /tmp/oh_my_bash
}

function intro() {
    /usr/bin/env clear
    source ${INSTALLED_PROGRAM}
}

setup
copy_files
cleanup
