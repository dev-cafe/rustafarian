#!/usr/bin/env bash

docker run \
       --env MATURIN_PASSWORD="$MATURIN_PASSWORD" \
       --rm \
       -v "$(pwd)":/io \
       konstin2/maturin publish \
       --python python3.6 python3.7 \
       --username robertodr \
       --password "$MATURIN_PASSWORD"
