#!/usr/bin/env bash

# Use https://hub.docker.com/r/robertodr/maturin to deploy

docker run \
       --env MATURIN_PASSWORD="$MATURIN_PASSWORD" \
       --rm \
       -v "$(pwd)":/io \
       robertodr/maturin \
       publish \
       --interpreter python3.6 python3.7 \
       --username robertodr \
       --password "$MATURIN_PASSWORD"
