#!/bin/sh

## evil patch to replace background color in code samples
CONFIG_FILE=node_modules/shiki/themes/github-light.json
## if the file is missing, quit
if [ ! -f $CONFIG_FILE ]; then
    echo "File $CONFIG_FILE not found. Exiting."
    return 1
fi

## replace the background color in the config file
sed -i "s/\"editor.background\": \"#fff\"/\"editor.background\": \"#eee\"/g" $CONFIG_FILE

## "normal" start of slidev presentation
npm run dev