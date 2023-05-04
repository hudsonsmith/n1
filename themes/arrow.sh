#! /usr/bin/env bash

source ~/.n1/prompt_tools/*

user="${USER:0:1}"
hostname="${HOSTNAME:0:1}"

export PS1="${reset}${white}${bold}[${cyan}${user}${red}@${cyan}${hostname}${white}] ${git_stats}${bold}${red}➜${reset}  "
preview="${reset}${white}${bold}[${cyan}${user}${red}@${cyan}${hostname}${white}] ${git_stats}${bold}${red}➜${reset}  "