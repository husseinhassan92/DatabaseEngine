#! /usr/bin/bash

#!/usr/bin/bash

while true
do
    read -p "Enter Database Name : " db_name
    case $db_name in
        '')
            echo "The Name Of Database Can't Be Empty"
        continue;;
        [0-9]*)
            echo "The Name Can't Begin With a Number"
        continue;;
        [a-zA-Z_]*)
            if [[ $db_name =~ .[[:space:]]+. ]]; then
                while true; do
                    db_name=`echo $db_name | tr ' ' '_'`
                    read -p "Do You Mean $db_name ? [y|N] " condition
                    case $condition in
                        [Yy])
                            if [ -d "../.Data/$db_name" ]
                            then
                                rm -rf ../.Data/$db_name
                                echo "$db_name Deleted"
                                break 2
                            else
                                echo "$db_name Not Found"
                                break 2
                            fi
                        ;;
                        [Nn])
                        break;;
                        *)
                            echo "You Have Entered Invaild Condition"
                            continue
                    esac
                done
            else
                if [ -d "../.Data/$db_name" ]
                then
                    rm -rf ../.Data/$db_name
                    echo "$db_name Deleted Successfully"
                    break
                else
                    echo "$db_name Not Found"
                    break
                fi
            fi
        ;;
        *)
            echo "The Name Can't Begin With a Special character"
            continue
    esac
done




