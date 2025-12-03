#!/usr/bin/env bash

echo -e "$(<script/logo.txt )"

echo

echo "Please select an option from the list:"

options=("Automated setup" "Manual setup" "Quit")

COLUMNS=1 
select opt in "${options[@]}"
do  
    case $opt in
        "Automated setup")
            echo
            ./script/auto.sh 
            break;;
        "Manual setup")
           echo
            ./script/manual.sh 
            break;;
        "Quit")
           echo "Goodbye!"
           break;;
        *)
           echo "Please select a valid option."
           ;;
    esac
done