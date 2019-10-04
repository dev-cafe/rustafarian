#!/usr/bin/env bash

# Use https://hub.docker.com/r/konstin2/maturin to deploy

docker run \
       --env MATURIN_PASSWORD="$MATURIN_PASSWORD" \
       --rm \
       -v "$(pwd)":/io \
       konstin2/maturin:master \
       publish \
       --python python3.6 python3.7 \
       --username robertodr \
       --password "$MATURIN_PASSWORD"
