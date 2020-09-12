# 本番・開発コンテナで共通でベースとするイメージ
# 開発コンテナにのみ必要なものはここでは入れない

FROM ubuntu:20.04

# apt-get
RUN apt-get update \
&&  apt-get install -y --no-install-recommends \
    curl \
    python3 \
    python3-pip \
    jq \
&&  apt-get -y clean \
&&  rm -rf /var/lib/apt/lists/*

# pip
RUN python3 -m pip install \
    factorio-rcon-py
