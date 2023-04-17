#! /usr/bin/env bash

function main() {
    # if [[ ! ":$PATH:" == *"$HOME/bin"* ]]; then
    #     echo "Adding ~/bin to path"
    #     echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    # fi

    # Add the executable.
    mkdir -p ~/bin
    cp main.sh ~/bin/omb

    mkdir -p ~/omb/themes
    cp themes/* ~/omb/themes/

    mkdir -p ~/omb/src
    cp src/* ~/omb/src

    # Add the alias for the source omb so that a omb can add a new PS1.
    echo 'alias omb="source ~/bin/omb"' >> ~/.bashrc
    source ~/.bashrc
}

main