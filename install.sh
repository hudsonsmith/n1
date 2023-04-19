#! /usr/bin/env bash

source ./installer_utils/*


util::alert "Creating directories..."

# Add the executable.
mkdir -p ~/.omb
cp main.sh ~/.omb/omb

mkdir -p ~/.omb/themes
cp themes/* ~/.omb/themes/

mkdir -p ~/.omb/src
cp src/* ~/.omb/src

mkdir -p ~/.omb/prompt_tools
cp prompt_tools/* ~/.omb/prompt_tools/


alias_text='alias omb="source ~/.omb/omb"'
alias_count=$(cat ~/.bashrc | grep "${alias_text}" | wc -l)

# Check if the alias already exists, if not, create it.
if (( $alias_count <= 0 )); then
    # Use `source` so that a new PS1 can be applied immediately.
    util::alert "Adding alias to ~/.bashrc"
    echo "${alias_text}" >> ~/.bashrc

else
    util::alert "Alias already exists"
fi


# If a default theme is not set, set it.
if [[ $(cat ~/.bashrc | grep "omb set" | wc -l) != "1" ]]; then
    util::alert "Adding default theme"
    echo "omb set arrow" >> ~/.bashrc

else
    util::alert "Default theme already set"
fi