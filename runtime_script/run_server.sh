#!/bin/bash

# config
SAVE_FILE_DIR=/opt/local/factorio/saves
SAVE_FILE_PATH=$SAVE_FILE_DIR/world.zip
RCON_PORT=34198
RCON_PASSWORD=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`

echo "RCON_PORT: $RCON_PORT"
echo "RCON_PASSWORD: $RCON_PASSWORD"

# セーブファイルが１つもなければセーブデータを作る
ls $SAVE_FILE_DIR/*.zip
if [ $? -ne 0 ]; then
    mkdir -p $SAVE_FILE_DIR
　　　　    factorio --create $SAVE_FILE_PATH
fi

# headless モードでサーバー起動
factorio --start-server-load-latest --rcon-port $RCON_PORT --rcon-password $RCON_PASSWORD &

# 自動終了スクリプトを実行
sleep 10
python3 /opt/local/script/auto_shutdown.py --port $RCON_PORT --password $RCON_PASSWORD &

# 終了待機
wait

# GCE 環境の場合はインスタンスをシャットダウン
curl http://metadata.google.internal
if [ $? -eq 0 ]; then
    # Google Compute Engine 環境下の場合はインスタンス停止を実行
    gce_access_token=`curl -X GET -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token | jq -r '.access_token'`
    gce_project_id=`curl -X GET -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/project/project-id`
    gce_zone=`curl -X GET -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone | sed -r "s/.+\/(.+)/\1/"`
    gce_hostname=$HOSTNAME
    curl -X POST -H "Authorization":"Bearer $gce_access_token" "https://www.googleapis.com/compute/v1/projects/$gce_project_id/zones/$gce_zone/instances/$gce_hostname/stop"
    exit 0
fi

# 正常終了
exit 0
