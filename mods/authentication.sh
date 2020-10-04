#!/bin/bash

# usage text
SH_BASE_NAME=`basename $0`
SH_DIR_PATH=`dirname $0`
USAGE_TEXT="$SH_BASE_NAME <USER_NAME> <PASSWORD>"

# arguments
USER_NAME=$1
PASSWORD=$2
echo USER_NAME = $USER_NAME
echo PASSWORD = $PASSWORD
if [ -z "$USER_NAME" ] || [ -z "$PASSWORD" ]; then
    echo usage: $USAGE_TEXT
    exit 1
fi

# call authentication API
ACCESS_TOKEN=`curl -X POST -d "username=$USER_NAME" -d "password=$PASSWORD" -d "require_game_ownership=true" https://auth.factorio.com/api-login | jq -r .[]`
if [ $? -ne 0 ]; then
    exit 1
fi
echo $ACCESS_TOKEN

# save access token as file
echo {\"username\":\"$USER_NAME\", \"token\":\"$ACCESS_TOKEN\"} > ${SH_DIR_PATH}/authentication.json
echo save authentication information file as "${SH_DIR_PATH}/authentication.json"

exit 0
