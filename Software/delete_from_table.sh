#!/usr/bin/bash

echo "Select Your Table Number From The Menu"
array=(*)
select table_name in "${array[@]}"
do
    if [ -n "$table_name" ]
    then
        echo "---------------You Select $table_name table-----------------"
        break
    fi
done

while true
do
    select choice in "DELETE_ALL" "DELETE_ROW" "DELETE_COLUMN" "QUIT"
    do
        case $choice in
            "DELETE_ALL")
                sed -i '/^[0-9]/d' "$table_name"
                echo "The Table Deleted Successfully"
            ;;
            "DELETE_ROW")
                read -p "Input The PK Of The Row: " pk
                row=$(awk -v pk="$pk" -F: '$1 == pk' "$table_name")
                if [ -n "$row" ]; then
                    sed -i "/^$pk:/d" "$table_name"
                    echo "The Row Deleted Successfully"
                else
                    echo "The PK Is Not Exist"
                fi
            ;;
            "DELETE_COLUMN")
                read -p "Input The Column Name: " column_name
                col_index=$(awk -F: -v col="$column_name" 'NR==1 { for (i=1; i<=NF; i++) { if ($i == col) { print i } } }' "$table_name")
                if [ -n "$col_index" ]; then
                    echo "------------ Deleted Column '$column_name' -------------"
                    awk -F: -v col="$col_index" 'NR>2 { rm $col }' "$table_name" | sed 's/: /:/'
                else
                    echo "You Entered Incorrect Column Name"
                fi
            ;;
            "QUIT")
                echo "Return to the Main Menu"
                cd ../../Software
                ./main.sh
                exit $?
            ;;
            *)
                echo "You Entered an Invalid Choice"
            ;;
        esac
        break
    done
done
