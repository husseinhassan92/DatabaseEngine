#! /usr/bin/bash

echo "Welocme to MyDB"
PS3="=>"

if [[ -d "../.Data" ]]; then
    echo "DB Aleardy Exists"
else
    echo "DB created"
    mkdir ../.Data
fi


select option in "Create DB" "List DB" "Connect DB" "Drop DB" "Backup" "Exit"
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
            . ./backup_db.sh
        ;;
        6)
            echo "Good Bye"
            break
        ;;
        *)
            echo "Invaild choice"
        ;;
    esac
done