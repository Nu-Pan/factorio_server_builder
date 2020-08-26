#!/bin/bash

curl http://metadata.google.internal
if [ $? -eq 0 ]; then
    # Google Compute Engine 環境下の場合はインスタンス停止を実行
    gce_access_token=`curl -X GET -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token | jq -r '.access_token'`
    gce_project_id=`curl -X GET -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/project/project-id`
    gce_zone=`curl -X GET -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone | sed -r "s/.+\/(.+)/\1/"`
    gce_hostname=$HOSTNAME
    curl -X POST -H "Authorization":"Bearer $gce_access_token" "https://www.googleapis.com/compute/v1/projects/$gce_project_id/zones/$gce_zone/instances/$gce_hostname/stop"
    exit 0
else
    # デフォルトでは SIGINT を送信
    pkill -ecx --signal INT factorio
fi

# 正常終了
exit 0
