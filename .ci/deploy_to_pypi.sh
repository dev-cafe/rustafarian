#!/usr/bin/env bash

poetry run maturin publish \
       --interpreter 3.6 \
       --username robertodr \
       --password "$PYPI_PASSWORD"
