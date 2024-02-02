#!/bin/bash

# Define color variables
RED='\e[91m'
BLUE='\e[34m'
GREEN='\e[32m'
RESET='\e[0m'

echo -e "\n${RED}Select Your Table Number From The Menu${RESET}\n"
array=(*)
select table_name in "${array[@]}"
do
  if [ -n "$table_name" ]
  then
    echo -e "\n${GREEN} You Selected ${table_name} Table${RESET}\n"
    break
  fi
done

while true
do
  select choice in "SELECT_ALL" "SELECT_ROW" "SELECT_COLUMN" "QUIT"
  do
    case $choice in 
      "SELECT_ALL")
        echo -e "\n${GREEN}--------------The ${table_name} Data is----------${RESET}\n"
        awk 'NR != 2' "$table_name" | column -t -s ":" | sed 's/^/\t/'
        ;;
      "SELECT_ROW")
        read -p "Input The PK Of The Row: " pk
        row=$(awk -v pk="$pk" -F: '$1 == pk' "$table_name")
        if [ -n "$row" ]; then
          echo -e "\n${GREEN}------------ Your Selected Row is -------------${RESET}"
          echo -e "\n$row \n" | column -t -s ":" | sed 's/^/\t/'
        else
          echo -e "\n${RED}This PK Is Not Exist${RESET}\n"
        fi
        ;;
      "SELECT_COLUMN")
        read -p "Input The Column Name: " column_name
        col_index=$(awk -F: -v col="$column_name" 'NR==1 { for (i=1; i<=NF; i++) { if ($i == col) { print i } } }' "$table_name")
        if [ -n "$col_index" ]; then
          echo -e "\n ${BLUE}------------ Data for Column '${column_name}' -------------${RESET}"
          awk -F: -v col="$col_index" 'NR!=2 { print $col }' "$table_name" | sed 's/: /:/' | column -t -s ":" | sed 's/^/\t/'
        else
          echo -e "\n${RED}You Entered Incorrect Column Name${RESET}\n"
        fi
        ;;  
      "QUIT")
        echo -e "\n${RED}Return to the Main Menu${RESET}\n"
        cd ../../Software
        ./main.sh
        exit $?
        ;;
      *)
        echo -e "\n${RED}You Entered an Invalid Choice${RESET}\n"
        ;;
    esac
    break
  done
done
