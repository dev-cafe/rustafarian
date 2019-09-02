#!/usr/bin/env bash

poetry run maturin publish \
       --username robertodr \
       --password "$PYPI_PASSWORD"
