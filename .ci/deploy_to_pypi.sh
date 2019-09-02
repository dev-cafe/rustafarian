#!/usr/bin/env bash

maturin publish \
       --username robertodr \
       --password "$PYPI_PASSWORD"
