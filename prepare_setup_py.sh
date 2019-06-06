#!/bin/bash

set -e

PACKAGE_NAME=libinjection-wheel
VERSION="0.1.0"

sed -i'.bak' -e "s/name\s\+=\s\+'libinjection'/name = '${PACKAGE_NAME}'/g" libinjection/python/setup.py
sed -i'.bak' -e "s/url\s\+=.\+,/url = 'https:\/\/github.com\/sqreen\/libinjection-build-python',/g" libinjection/python/setup.py
sed -i'.bak' -e "s/version\s\+=.\+,/version = '${VERSION}',/g" libinjection/python/setup.py
