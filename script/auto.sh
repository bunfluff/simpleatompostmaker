#!/usr/bin/env bash

echo "Entering automated setup..."

while true; do
  read -r -p "Is your automation file in place and properly configured? (/configs/auto.conf) [y/N]  " -n 1 auto_choose

  echo # move to a new line

  case "$auto_choose" in 

    [Yy]* )
      template_file=configs/atom.tpl
      automation_file=configs/auto.conf
      content_file=configs/content.html
      . "${automation_file}"
      CONTENT=$(<"$content_file")

      eval "echo \"$(cat "${template_file}")\"" > output/out.txt
      echo "File generated at output/out.txt"
      break
    ;;

    [Nn]* )
      echo "Exiting setup..."
      exit 1
    ;;

    * )
      echo "Invalid input. Please enter 'y' or 'n'." >&2
      ;;
  esac
done