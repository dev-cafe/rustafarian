#!/usr/bin/env bash

pipenv run pyo3-pack publish \
       --username robertodr \
       --password "$PYPI_PASSWORD"
