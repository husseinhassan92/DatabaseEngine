#!/usr/bin/bash

read -p "Enter Table Name : " table_name
case $table_name in
    '')
        echo "The Name Of Table Can't Be Empty"
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
                                read -p "Enter The ID Of The Row: " pk
                                if [[ $pk =~ [0-9]+ ]]; then
                                    row=$(awk -v pk="$pk" -F: '$1 == pk' "$table_name")
                                    if [ -n "$row" ]; then
                                        echo "The Row To update"
                                        old_row=$(sed -n "/^$pk:/p" "$table_name")
                                        echo $old_row
                                    else
                                        echo "The PK Is Not Exist"
                                        continue
                                    fi
                                    
                                    fileds_num=`head -n1 $table_name | grep -o ":" | wc -l`
                                    fields=$(($fileds_num+1))
                                    read -p "Enter The field index To Update: " index
                                    if [[ $index =~ [0-9]+ ]]; then
                                        if (( $index == 1 )); then
                                            echo "The ID Can't Be Changed"
                                            elif (( $index > $fields )); then
                                            echo "The column index Not Found"
                                        else
                                            new_row=$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f 1)
                                            data_type=$(head -n2 $table_name | tail -n1 |cut -d : -f $index)
                                            read -p "Enter The Value To Update: " value
                                            if [[ $data_type =~ 'integer' ]]; then
                                                if [[ $value =~ [0-9]+ ]]; then
                                                    for ((i=2; i<$index; i++)); do
                                                        new_row+=":$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f $i)"
                                                    done
                                                    
                                                    echo $data_type
                                                    new_row+=":$value"
                                                    for ((i=(( $index+1)); i<=$fields; i++)); do
                                                        new_row+=":$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f $i)"
                                                    done
                                                    sed -i "/^$pk:/d" "$table_name"
                                                    echo "The Row Updated"
                                                    echo $new_row >> $table_name
                                                else
                                                    echo "The Value Must be Integer"
                                                fi
                                            else
                                                for ((i=2; i<$index; i++)); do
                                                    new_row+=":$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f $i)"
                                                done
                                                new_row+=":$value"
                                                for ((i=(( $index+1)); i<=$fields; i++)); do
                                                    new_row+=":$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f $i)"
                                                done
                                                sed -i "/^$pk:/d" "$table_name"
                                                echo "The Row Updated"
                                                echo $new_row >> $table_name
                                            fi
                                        fi
                                    else
                                        echo "ID Must be Integer"
                                        continue
                                    fi
                                else
                                    echo "ID Must be Integer"
                                    continue
                                    
                                fi
                                
                                read -p "Do You Want Update another Row? [y|N] " cond
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
                    read -p "Enter The ID Of The Row: " pk
                    if [[ $pk =~ [0-9]+ ]]; then
                        row=$(awk -v pk="$pk" -F: '$1 == pk' "$table_name")
                        if [ -n "$row" ]; then
                            echo "The Row To update"
                            old_row=$(sed -n "/^$pk:/p" "$table_name")
                            echo $old_row
                        else
                            echo "The PK Is Not Exist"
                            continue
                        fi
                        
                        fileds_num=`head -n1 $table_name | grep -o ":" | wc -l`
                        fields=$(($fileds_num+1))
                        read -p "Enter The field index To Update: " index
                        if [[ $index =~ [0-9]+ ]]; then
                            if (( $index == 1 )); then
                                echo "The ID Can't Be Changed"
                                elif (( $index > $fields )); then
                                echo "The column index Not Found"
                            else
                                new_row=$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f 1)
                                data_type=$(head -n2 $table_name | tail -n1 |cut -d : -f $index)
                                read -p "Enter The Value To Update: " value
                                if [[ $data_type =~ 'integer' ]]; then
                                    if [[ $value =~ [0-9]+ ]]; then
                                        for ((i=2; i<$index; i++)); do
                                            new_row+=":$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f $i)"
                                        done
                                        
                                        echo $data_type
                                        new_row+=":$value"
                                        for ((i=(( $index+1)); i<=$fields; i++)); do
                                            new_row+=":$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f $i)"
                                        done
                                        sed -i "/^$pk:/d" "$table_name"
                                        echo "The Row Updated"
                                        echo $new_row >> $table_name
                                    else
                                        echo "The Value Must be Integer"
                                    fi
                                else
                                    for ((i=2; i<$index; i++)); do
                                        new_row+=":$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f $i)"
                                    done
                                    new_row+=":$value"
                                    for ((i=(( $index+1)); i<=$fields; i++)); do
                                        new_row+=":$(sed -n "/^$pk:/p" "$table_name" | cut -d : -f $i)"
                                    done
                                    sed -i "/^$pk:/d" "$table_name"
                                    echo "The Row Updated"
                                    echo $new_row >> $table_name
                                fi
                            fi
                        else
                            echo "ID Must be Integer"
                            continue
                        fi
                    else
                        echo "ID Must be Integer"
                        continue
                        
                    fi
                    
                    read -p "Do You Want Update another Row? [y|N] " cond
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