#! /usr/bin/env bash

INSTALLED_PATH="$HOME/.n1"

function setup () {
    [[ -d "/tmp/oh_my_bash/" ]] && rm -rf /tmp/oh_my_bash/

    git clone https://github.com/hudsonsmith/oh_my_bash.git /tmp/oh_my_bash
    cd /tmp/oh_my_bash

    for file in ./installer_utils/*.sh; do
        [[ -f "$file" ]] && source "$file"
    done
}

function setup_dev () {
    for file in ./installer_utils/*.sh; do
        [[ -f "$file" ]] && source "$file"
    done
}

function copy_files () {
    echo "Installed Path: ${INSTALLED_PATH}"
    touch ~/.bashrc

    util::alert "Creating directories..."

    rm -rf "${INSTALLED_PATH}"
    mkdir -p "${INSTALLED_PATH}"
    cp main.sh "${INSTALLED_PATH}/n1"

    mkdir -p "${INSTALLED_PATH}/themes"
    cp themes/* "${INSTALLED_PATH}/themes/"

    mkdir -p "${INSTALLED_PATH}/src"
    cp src/* "${INSTALLED_PATH}/src"

    mkdir -p "${INSTALLED_PATH}/prompt_tools"
    cp prompt_tools/* "${INSTALLED_PATH}/prompt_tools/"

    cp install.sh "${INSTALLED_PATH}/"

    alias_text="alias n1='source ${INSTALLED_PATH}/n1'"
    if ! grep -Fxq "${alias_text}" ~/.bashrc; then
        util::alert "Adding alias to ~/.bashrc"
        echo "${alias_text}" >> ~/.bashrc
    else
        util::alert "Alias already exists! :)"
    fi

    if ! grep -Fxq "n1 init" ~/.bashrc; then
        util::alert "Adding default theme"
        echo "n1 init" >> ~/.bashrc
    else
        util::alert "Command \`n1 init\` already present! :)"
    fi

    cp ./n1.conf "${INSTALLED_PATH}/"
}

function cleanup () {
    cd -
    rm -rf /tmp/oh_my_bash
}

function intro () {
    /usr/bin/env clear
    ${INSTALLED_PATH}/n1
}

# If argv prompt is set as dev, install from current repo.
[[ "${1}" == "dev" ]] && setup_dev || setup
copy_files
cleanup
