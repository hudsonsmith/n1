#! /usr/bin/env bash

source ~/.n1/prompt_tools/git.sh

git_stats () {
	if [[ ! $(__git_ps1) ]]; then
		return
	fi

	local STATUS=$(git status -s 2> /dev/null)

	if echo "$STATUS" | grep -q "fatal"; then
		return
	fi

	local UNTRACKED=$(echo "$STATUS" | grep "^??" | wc -l)
	local MODIFIED=$(echo "$STATUS" | grep "^ M\|^MM" | wc -l)
	local DELETED=$(echo "$STATUS" | grep "^ D" | wc -l)

	stats=""

	#if [ $MODIFIED != 0 ]; then
	stats="$green$MODIFIED~$reset "
	#fi
	#if [ $UNTRACKED != 0 ]; then
	stats+="$red$DELETED-$reset "
	stats+="$purple$UNTRACKED!$reset "
	#fi
	echo -e "$stats"
}

user="${USER:0:1}"
hostname="${HOSTNAME:0:1}"

export PS1="${reset}${white}${bold}[${cyan}${user}${red}@${cyan}${hostname}${white} ${green}\W${white}]$reset$yellow\$(__git_ps1) \$(git_stats)${bold}${white}${bold}${red}➜${reset}  "
preview="${reset}${white}${bold}[${cyan}${user}${red}@${cyan}${hostname}${white}]$reset$yellow (main) $reset${green}2~${reset} ${red}5-${reset} ${purple}3!${reset}${git_stats}${bold}${red} ➜${reset}  "
