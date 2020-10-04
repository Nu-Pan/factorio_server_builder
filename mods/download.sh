#!/bin/bash

# usage text
SH_BASE_NAME=`basename $0`
USAGE_TEXT="$SH_BASE_NAME <OUTPUT_FILE_PATH> <SHA1> <AUTHENTICATION_FILE_PATH> "

# arguments
OUTPUT_FILE_PATH=$1
SHA1=$2
AUTHENTICATION_FILE_PATH=$3
echo OUTPUT_FILE_PATH = $OUTPUT_FILE_PATH
echo SHA1 = $SHA1
echo AUTHENTICATION_FILE_PATH = $AUTHENTICATION_FILE_PATH
if [ -z "$OUTPUT_FILE_PATH" ] || [ -z "$SHA1" ] || [ -z "$AUTHENTICATION_FILE_PATH" ]; then
    echo usage: $USAGE_TEXT
    exit 1
fi

# HTTP GET mod info.
MOD_FULL_NAME=`basename $OUTPUT_FILE_PATH`
MOD_NAME=${MOD_FULL_NAME%_*}
echo MODE_NAME = $MOD_NAME
MOD_INFO=`curl -X GET https://mods.factorio.com/api/mods/${MOD_NAME}`
if [ $? -ne 0 ]; then
    exit 1
fi

# filter download URL by sha1
DOWNLOAD_URL=` echo $MOD_INFO | jq -r --arg SHA1 "$SHA1" '.releases[] | select (.sha1==$SHA1) | .download_url'`
if [ $? -ne 0 ]; then
    exit 1
fi

# load token
USER_NAME=`cat ${AUTHENTICATION_FILE_PATH} | jq -r '.username'`
ACCESS_TOKEN=`cat ${AUTHENTICATION_FILE_PATH} | jq -r '.token'`

echo DOWNLOAD_URL = $DOWNLOAD_URL
echo USER_NAME = $USER_NAME
echo ACCESS_TOKEN = $ACCESS_TOKEN

# download MOD
curl -GL --data-urlencode "username=${USER_NAME}" --data-urlencode "token=${ACCESS_TOKEN}" "https://mods.factorio.com${DOWNLOAD_URL}" --output "${OUTPUT_FILE_PATH}"
if [ $? -ne 0 ]; then
    exit 1
fi

exit 0
