#! /usr/bin/env bash

source ./installer_utils/colors.sh

function util::alert() {
  echo -e "${blue}[${reset}${italic}i${reset}${blue}] ${reset}${bold}${1}${reset}"
}