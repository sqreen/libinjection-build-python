#!/bin/bash

set -e

PACKAGE_NAME=libinjection-wheel
VERSION="0.1.0"

sed -i'.bak' -e "s/name\s\+=\s\+'libinjection'/name = '${PACKAGE_NAME}'/" libinjection/python/setup.py
sed -i'.bak' -e "s/url\s\+=.\+,/url = 'https:\/\/github.com\/sqreen\/libinjection-build-python',/" libinjection/python/setup.py
sed -i'.bak' -e "s/version\s\+=.\+,/version = '${VERSION}',/" libinjection/python/setup.py
