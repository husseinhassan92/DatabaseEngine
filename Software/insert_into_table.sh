#!/usr/bin/bash

read -p "Enter Table Name : " table_name
case $table_name in
    '')
        echo "The Name Of Database Can't Be Empty"
    continue;;
    [0-9]*)
        echo "The Name Can't Begin With a Number"
    continue;;
    [a-zA-Z_]*)
        if [[ $table_name =~ .[[:space:]]+. ]]; then
            while true; do
                table_name=`echo $table_name | tr ' ' '_'`
                read -p "Do You Mean $table_name ? [y|N] " condition
                case $condition in
                    [Yy])
                        if [ -f "./$table_name" ]
                        then
                            while true; do
                                read -p "Do You Want ID to be Auto Increment ? [y|N] " condition
                                case $condition in
                                    [Yy])
                                        row_num=`wc -l $table_name | cut -d " " -f 1`
                                        row_ind="$(($row_num-1))"
                                        i="$row_ind"
                                        val=`sed -n "/$i:/p" $table_name | cut -d : -f 1`
                                        while [[ $val ]]; do
                                            val=`sed -n "/$i:/p" $table_name | cut -d : -f 1`
                                            i=$(( $i + 1 ))
                                        done
                                        row="$i"
                                        fileds_num=`head -n1 employee | grep -o ":" | wc -l`
                                        fields=$(($fileds_num+1))
                                        for ((i=2; i<=$fields; i++))
                                        do
                                            read -p "Enter `cut -d : -f $i  $table_name | head -1` Value: " value
                                            row+=":$value"
                                        done
                                        
                                        echo "The row Insrted"
                                        echo $row >> $table_name
                                    ;;
                                    [Nn])
                                        while true; do
                                            read -p "Enter ID Value: " value
                                            val=`sed -n "/$value:/p" $table_name | cut -d : -f 1`
                                            if [[ $val ]]; then
                                                echo "This ID Already Exists"
                                                continue
                                            else
                                                row_num=`wc -l $table_name | cut -d " " -f 1`
                                                row="$(($row_num-1))"
                                                row="$value"
                                                break
                                            fi
                                        done
                                        fileds_num=`head -n1 employee | grep -o ":" | wc -l`
                                        fields=$(($fileds_num+1))
                                        for ((i=2; i<=$fields; i++))
                                        do
                                            read -p "Enter `cut -d : -f $i  $table_name | head -1` Value: " value
                                            row+=":$value"
                                        done
                                        
                                        echo "The row Insrted"
                                        echo $row >> $table_name
                                    ;;
                                    *)
                                        echo "You Have Entered Invaild Condition"
                                esac
                                
                                read -p "Do You Want Insert another Row? [y|N] " cond
                                case $cond in
                                    [Yy])
                                        continue
                                    ;;
                                    [Nn])
                                        break 2
                                    ;;
                                    *)
                                        echo "You Have Entered Invaild Condition"
                                esac
                            done
                        else
                            echo "$table_name Not Found"
                            break 
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
            if [ -f "./$table_name" ]
            then
                while true; do
                    read -p "Do You Want ID to be Auto Increment ? [y|N] " condition
                    case $condition in
                        [Yy])
                            row_num=`wc -l $table_name | cut -d " " -f 1`
                            row_ind="$(($row_num-1))"
                            i="$row_ind"
                            val=`sed -n "/$i:/p" $table_name | cut -d : -f 1`
                            while [[ $val ]]; do
                                val=`sed -n "/$i:/p" $table_name | cut -d : -f 1`
                                i=$(( $i + 1 ))
                            done
                            row="$i"
                            fileds_num=`head -n1 employee | grep -o ":" | wc -l`
                            fields=$(($fileds_num+1))
                            for ((i=2; i<=$fields; i++))
                            do
                                read -p "Enter `cut -d : -f $i  $table_name | head -1` Value: " value
                                row+=":$value"
                            done
                            
                            echo "The row Insrted"
                            echo $row >> $table_name
                        ;;
                        [Nn])
                            while true; do
                                read -p "Enter ID Value: " value
                                val=`sed -n "/$value:/p" $table_name | cut -d : -f 1`
                                if [[ $val ]]; then
                                    echo "This ID Already Exists"
                                    continue
                                else
                                    row_num=`wc -l $table_name | cut -d " " -f 1`
                                    row="$(($row_num-1))"
                                    row="$value"
                                    break
                                fi
                            done
                            fileds_num=`head -n1 employee | grep -o ":" | wc -l`
                            fields=$(($fileds_num+1))
                            for ((i=2; i<=$fields; i++))
                            do
                                read -p "Enter `cut -d : -f $i  $table_name | head -1` Value: " value
                                row+=":$value"
                            done
                            
                            echo "The row Insrted"
                            echo $row >> $table_name
                        ;;
                        *)
                            echo "You Have Entered Invaild Condition"
                    esac
                    
                    read -p "Do You Want Insert another Row? [y|N] " cond
                    case $cond in
                        [Yy])
                            continue
                        ;;
                        [Nn])
                            break
                        ;;
                        *)
                            echo "You Have Entered Invaild Condition"
                    esac
                done
            else
                echo "$table_name Not Found"
            fi
        fi
    ;;
    *)
        echo "The Name Can't Begin With a Special character"
esac

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