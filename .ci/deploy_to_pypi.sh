#!/usr/bin/env bash

docker run --rm -v $(pwd):/io \
       konstin2/maturin publish \
       --username robertodr \
       --password "$MATURIN_PASSWORD"
