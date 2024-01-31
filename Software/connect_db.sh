
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
                                cd ../.Data/$db_name
                                echo "$db_name DB Connected"
                                PS3="$db_name=>"
                                select option in "Create Table" "Show Tables" "Insert Into Table" "Update Table" "Drop Table" "Use Table" "Dlete From Table" "Return to Main Menu"
                                do
                                    case $REPLY in
                                        1)
                                            . ../../Software/create_table.sh
                                        ;;
                                        2)
                                            . ../../Software/list_table.sh $db_name
                                        ;;
                                        3)
                                            . ../../Software/insert_into_table.sh
                                        ;;
                                        4)
                                            . ../../Software/update_table.sh
                                        ;;
                                        5)
                                            . ../../Software/drop_table.sh
                                        ;;
                                        6)
                                            . ../../Software/select_from_table.sh
                                        ;;
                                        7)
                                            . ../../Software/delete_from_table.sh
                                        ;;
                                        8)
                                            echo "Return to the Main Menu"
                                            cd ../../Software
                                            ./main.sh; exit $?
                                        ;;
                                        *)
                                            echo "Invaild choice"
                                        ;;
                                    esac
                                done
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
                    cd ../.Data/$db_name
                    echo "$db_name DB Connected"
                    PS3="$db_name=>"
                    select option in "Create Table" "Show Tables" "Insert Into Table" "Update Table" "Drop Table" "Use Table"  "Dlete From Table" "Return to Main Menu"
                    do
                        case $REPLY in
                            1)
                                . ../../Software/create_table.sh
                            ;;
                            2)
                                . ../../Software/list_table.sh $db_name
                            ;;
                            3)
                                . ../../Software/insert_into_table.sh
                            ;;
                            4)
                                . ../../Software/update_table.sh
                            ;;
                            5)
                                . ../../Software/drop_table.sh
                            ;;
                            6)
                                . ../../Software/select_from_table.sh
                            ;;
                            7)
                                . ../../Software/delete_from_table.sh
                            ;;
                            8)
                                echo "Return to the Main Menu"
                                cd ../../Software
                                ./main.sh; exit $?
                            ;;
                            *)
                                echo "Invaild choice"
                            ;;
                        esac
                    done
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


# select option in "Create Table" "Show Tables" "Insert Into Table" "Update Table" "Drop Table" "Use Table" "Return to Main Menu"
# do
#     case $REPLY in
#         1)
#             echo "1"
#         ;;
#         2)
#             echo "2"
#         ;;
#         3)
#             echo "3"
#         ;;
#         4)
#             echo "4"
#         ;;
#         5)
#             echo "5"
#         ;;
#         6)
#             echo "6"
#         ;;
#         7)
#             echo "Return to the Main Menu"
#             cd ../../Software
#             . ./main.sh; exit $?
#         ;;
#         *)
#             echo "Invaild choice"
#         ;;
#     esac
# done