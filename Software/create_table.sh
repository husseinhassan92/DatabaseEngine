#!/bin/bash

while true
do
  read -p "Enter Table Name : " table_name

  case $table_name in
    '')
      echo "The TableName  Can't Be Empty"
      continue;;
    *[[:space:]]* )
      echo "The TableName Can't Contain Spaces"
      continue;;
    [0-9]*)
      echo "The TableName Can't Begin With a Number"
      continue;;  
    [a-zA-Z_]*[a-zA-Z_])
      if [ -f "$table_name" ]
      then
        echo "The Table is Already Exists"
        continue
      else
        touch "$table_name"
        break
      fi;;
    *)
      echo "You Have Entered Invalid Name"
      continue
  esac
done

# Inser Coulmns Number
while true
do
  read -p "Enter Number Of Fields in Table $table_name : " fields_num
  case $fields_num in
    0*)
      echo "The Number Of Fields Can't start with $fields_num "
      continue;;
    *[1-9] | *[1-9]*[0-9])
      echo "The Number Of Fields Will Be $fields_num"
      break;;
    *)
      echo "You Input an Invalid Number"
      continue;;
  esac
done

# Insert Columns Names and Types
let fields_num=$fields_num
echo "--------------Insert Your Metadata For $table_name -------------"
row_name=""
row_type=""

echo "The First Name Will Be Id By Default"
for ((i=2; i<=$fields_num; i++))
do
  while true
  do
    read -p "Enter $i Column Name : " col_name
    case $col_name in
      '')
        echo "The Column Name Can't Be Empty"
        continue;;
      *[[:space:]]*)
        echo "The Column Name Can't Contain Spaces"
        continue;;
      [0-9]*)
        echo "The Column Name Can't Begin With a Number"
        continue;;
      [a-zA-Z_]*[a-zA-Z0-9_])
        if grep -q "$col_name" <<< "$(head -n 1 $table_name)"
        then
          echo "This Column Is Already Exist"
        else
          if [ $i -eq 2 ]
          then
            row_name+="id:"$col_name
          else
            row_name+=":$col_name"
          fi 
          break
        fi;;
      *)
        echo "You Have Entered an Invalid Name"
        continue
    esac
  done
  echo "Select The Type Of Your Column"
  select data_type in "String" "Integer"
  do
    case $data_type in
      "String")
        if [ $i -eq 2 ]; then
          row_type+="integer:string"
        else
          row_type+=":string"
        fi
        break;;
      "Integer")
        if [ $i -eq 2 ]; then
          row_type+="integer:integer"
        else
          row_type+=":integer"
        fi
        break;;
      *)
        echo "Invalid Data Type"
    esac
  done
done

echo "$row_name" >> $table_name
echo "$row_type" >> $table_name

echo "----------Your Table Metadata is:
       $row_name
       $row_type
       " | column -t -s ":" | sed 's/^/\t/'
