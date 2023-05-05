#! /usr/bin/env bash

PS1="${bold}${green}\u ${blue}\w${reset}$(__git_ps1 " (%s)") \$ "
preview="${bold}${green}smith ${blue}matrix${reset} (main) $"