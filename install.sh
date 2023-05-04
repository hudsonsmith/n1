#! /usr/bin/env bash

source ./installer_utils/*


util::alert "Creating directories..."

# Add the executable.
mkdir -p ~/.n1
cp main.sh ~/.n1/n1

mkdir -p ~/.n1/themes
cp themes/* ~/.n1/themes/

mkdir -p ~/.n1/src
cp src/* ~/.n1/src

mkdir -p ~/.n1/prompt_tools
cp prompt_tools/* ~/.n1/prompt_tools/


alias_text='alias n1="source ~/.n1/n1"'
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
if [[ $(cat ~/.bashrc | grep "n1 set" | wc -l) != "1" ]]; then
    util::alert "Adding default theme"
    echo "n1 set arrow" >> ~/.bashrc

else
    util::alert "Default theme already set"
fi