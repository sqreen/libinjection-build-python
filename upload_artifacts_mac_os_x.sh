#!/bin/bash
set -e
set -x

. ./venv_3.6/bin/activate
pip install awscli
aws s3 cp dist/ "s3://sqreen-libinjection-travis-artefact/$(git rev-parse HEAD)/dist/" --recursive --exclude "*" --include "*.whl"
