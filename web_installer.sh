#! /usr/bin/env bash

function main() {
  git clone https://github.com/hudsonsmith/oh_my_bash.git /tmp/oh_my_bash

  cd /tmp/oh_my_bash
  chmod 755 ./install.sh

  ./install.sh

  cd ../oh_my_bash
  rm -rf oh_my_bash

  cd -

  echo "\n\nThanks for installing Oh My Bash!"
  echo -e "\nRun 'source ~/.bashrc' to finish the install."
  echo "Run 'omb' to see how to use this tool."
}

main