#! /usr/bin/env bash

function src::list_themes() {
  for file in $(ls ${1}); do
    source ${1}/${file}

    echo "${PS1}"
  done
}