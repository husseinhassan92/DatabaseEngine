#!/usr/bin/bash

ps3="Type Your Table Number to Drop"
echo "Select Your Table Number From The Menu"


array=(*)

select choice in "${array[@]}"
do
  if [ "$REPLY" -gt "${#array[@]}" ]
  then
    echo "$REPLY Not In Menu"
    continue
  else
    rm "${array[$REPLY-1]}"
    echo "${array[$REPLY-1]} Table Dropped Successfully..."
    break
  fi
done
