#! /usr/bin/env bash

# The file that gets pasted to the user's terminal to install.

function main() {
  git clone https://github.com/hudsonsmith/oh_my_bash.git /tmp/oh_my_bash

  [[ -d "/tmp/oh_my_bash/" ]] && rm -rf /tmp/oh_my_bash/
  cd /tmp/oh_my_bash
  chmod 755 ./install.sh

  ./install.sh

  cd ../oh_my_bash
  rm -rf oh_my_bash

  cd -

  echo "\n\nThanks for installing Oh My Bash!"
  echo -e "\nRun 'source ~/.bashrc' to finish the install."
  echo "Run 'n1' to see how to use this tool."
}

main
