#!/usr/bin/env bash

echo "Hello, welcome to the atom post maker. Let's start:"

echo -n "What's the title of your post? "
read -r title

read -r -p "Use today's date? [y/N] " -n 1 date_choose

echo # (optional) move to a new line

case "$date_choose" in 

  [Yy]* )
    chosen_date=$(date '+%B %-d, %Y')
    id_date=$(date '+%Y-%m-%d')
    echo "Okay! Using today's date, $chosen_date"
    blog_date=$(date --rfc-3339=seconds | sed 's/ /T/');;

  [Nn]* )
    read -r -p "Okay! What day would you like to use? Default: Jan 1 2000 : " custom_date
    if [ -z "$custom_date" ]; then
	    chosen_date='Jan 1 2000'

    else
        chosen_date=$custom_date

    fi
    echo "Okay! Using $(date --date="$chosen_date" '+%B %-d, %Y')"
    blog_date=$(date --date="$chosen_date" --rfc-3339=seconds | sed 's/ /T/')
    id_date=$(date --date="$chosen_date" '+%Y-%m-%d')
    ;;

  * )
    echo "Invalid input. Please enter 'y' or 'n'."
    ;;

esac

echo -n "What is the post's id? "
read -r id

while true; do
  echo -n "Please provide your post's link (or what it will be): "
  read -r link
  if [[ "$link" =~ ^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ ]]; then
    echo "Okay! Using $link"
    break
  else
    echo "Please try again"
  fi
done

read -r -p "Can I create your file? [y/N] " -n 1 file_choose

echo # (optional) move to a new line

case "$file_choose" in 

  [Yy]* )
    touch atom.conf
    echo -e "TITLE=$title\nIDDATE=$id_date\nID=$id\nLINK=$link\nDATE=$blog_date" > atom.conf
    echo "Okay! I've created $name.conf in the same directory as this script";;

  [Nn]* )
    echo "Aborting operation..."
    exit 1;;

  * )
    echo "Invalid input. Please enter 'y' or 'n'."
    ;;

esac