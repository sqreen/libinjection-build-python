#!/bin/bash

set -e

PACKAGE_NAME=libinjection-wheel
URL=

sed -i "s/name\s\+=\s\+'libinjection'/name = '${PACKAGE_NAME}'/" libinjection/python/setup.py
sed -i "s/url\s\+=.\+,/url = 'https:\/\/github.com\/sqreen\/libinjection-build-python',/" libinjection/python/setup.py
