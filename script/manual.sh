#!/usr/bin/env bash

echo "Entering manual setup..."

echo -n "What's the title of your post? "
read -r title

while true; do
  read -r -p "Use today's date? [y/N] " -n 1 date_choose

  echo # move to a new line
  case "$date_choose" in 

    [Yy]* )
      chosen_date=$(date '+%B %-d, %Y')
      id_date=$(date '+%Y-%m-%d')
      echo "Okay! Using today's date, $chosen_date"
      blog_date=$(date --rfc-3339=seconds | sed 's/ /T/')
      break;;

    [Nn]* )
      read -r -p "Okay! What date would you like to use? [Default: Jan 1 2000] : " custom_date
      if [ -z "$custom_date" ]; then
        chosen_date='Jan 1 2000'

      else
        chosen_date=$custom_date

      fi
      echo "Okay! Using $(date --date="$chosen_date" '+%B %-d, %Y')"
      blog_date=$(date --date="$chosen_date" --rfc-3339=seconds | sed 's/ /T/')
      id_date=$(date --date="$chosen_date" '+%Y-%m-%d')
      break;;

    * )
      echo "Invalid input. Please enter 'y' or 'n'." >&2
      ;;
  esac
done

echo -n "What is the post's id? "
read -r id

while true; do
  echo -n "Please provide your post's link (or what it will be): "
  read -r link
  if [[ "$link" =~ ^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ ]]; then
    echo "Okay! Using $link"
    break
  else
    echo "Invalid link. Please try again."
  fi
done

echo -n "What is the name of the author of this post? "
read -r author

while true; do
  echo -n "What is the homepage of the author of this post?: "
  read -r homepage
  if [[ "$homepage" =~ ^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ ]]; then
    echo "Okay! Using $homepage"
    break
  else
    echo "Invalid link. Please try again."
  fi
done

while true; do
  read -r -p "Is content.html in the configs folder? [y/N] " -n 1 content_choose

  echo # move to a new line
  case "$content_choose" in 

    [Yy]* )
      echo "Proceeding..."
      break;;

    [Nn]* )
      echo "Please create content.html and move it to the configs folder. Check the README.md for more information."
      continue;;

    * )
      echo "Invalid input. Please enter 'y' or 'n'." >&2
      ;;
  esac
done

while true; do
  read -r -p "Can I generate your file? [y/N] " -n 1 file_choose

  echo # move to a new line

  case "$file_choose" in 

    [Yy]* )
      echo -e "TITLE=$title\nIDDATE=$id_date\nID=$id\nLINK=$link\nDATE=$blog_date\nAUTHOR=$author\nHOMEPAGE=$homepage" > configs/manual.conf
      template_file=configs/atom.tpl
      configuration_file=configs/manual.conf
      content_file=configs/content.html
      . "${configuration_file}"
      CONTENT=$(<"$content_file")

      eval "echo \"$(cat "${template_file}")\"" > output/out.txt
      echo "File generated at output/out.txt"
      break;;

    [Nn]* )
      echo "Aborting operation..."
      exit 1;;

    * )
      echo "Invalid input. Please enter 'y' or 'n'." >&2
      ;;

  esac
done