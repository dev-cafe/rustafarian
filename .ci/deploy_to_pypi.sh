#!/usr/bin/env bash

maturin publish \
       --interpreter python3.6 \
       --username robertodr \
       --password "$MATURIN_PASSWORD"
