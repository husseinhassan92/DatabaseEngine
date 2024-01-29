#! /usr/bin/bash

if [ "$(ls .)" ]; then
    echo "Available Tables"
    ls .
else
    echo "No Tables to show"
fi


