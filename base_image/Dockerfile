# 本番コンテナがベースとするイメージ

FROM ubuntu:20.04

RUN apt-get update \
&&  apt-get install -y \
    curl \
&&  apt-get -y clean \
&&  rm -rf /var/lib/apt/lists/*
