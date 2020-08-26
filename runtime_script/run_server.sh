#!/bin/bash

# parameter
SAVE_FILE_DIR=/opt/local/factorio/user_save
SAVE_FILE_PATH=$SAVE_FILE_DIR/world.zip

# セーブファイルがなければ作る
if [ ! -f $SAVE_FILE_PATH ]; then
    mkdir -p $SAVE_FILE_DIR
    factorio --create $SAVE_FILE_PATH
fi

# headless モードでサーバー起動
factorio --start-server $SAVE_FILE_PATH

# 正常終了
exit 0
