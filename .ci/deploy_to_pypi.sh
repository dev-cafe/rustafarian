#!/usr/bin/env bash

pipenv run pyo3-pack publish \
       --repository-url https://test.pypi.org/legacy/ \
       --username robertodr \
       --password "$PYPI_PASSWORD"
