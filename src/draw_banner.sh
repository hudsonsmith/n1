#! /usr/bin/env bash

function src::draw_banner() {
    echo "
███╗   ██╗ ██╗
████╗  ██║███║
██╔██╗ ██║╚██║
██║╚██╗██║ ██║
██║ ╚████║ ██║
╚═╝  ╚═══╝ ╚═╝
    "

    echo '"Simplicity is efficiency"'
}

function src::draw_hr() {
    local line=$(printf "%$(tput cols)s") 
    echo "${line// /#}"
}