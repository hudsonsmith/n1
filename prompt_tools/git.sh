#! /usr/bin/env bash

source ~/.omb/prompt_tools/colors.sh


function git_stats() {
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
