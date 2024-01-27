#! /usr/bin/bash

if [ -d "../.Data" ] && [ "$(ls ../.Data)" ]; then
    echo "Available Databases"
    ls ../.Data
else
    echo "No Databases to show"
fi
