#! /usr/bin/bash
GREEN='\e[32m'
RESET='\e[0m'

echo -e  "\n${GREEN}Welocme to MyDB${RESET}\n"| sed 's/^/\t/'
PS3="=>"

if [[ -d "../.Data" ]]; then
    echo ""
else
    echo "DB created"
    mkdir ../.Data
fi


select option in "Create DB" "List DB" "Connect DB" "Drop DB" "Exit"
do
    case $REPLY in
        1)
            . ./create_db.sh
        ;;
        2)
            . ./list_db.sh
        ;;
        3)
            . ./connect_db.sh
        ;;
        4)
            . ./drop_db.sh
        ;;
        5)
            echo "Good Bye"
            break
        ;;
        *)
            echo "Invaild choice"
        ;;
    esac
done