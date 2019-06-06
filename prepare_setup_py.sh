#!/bin/bash

set -e
set -x

PACKAGE_NAME=libinjection-wheel
VERSION="0.1.0"

perl -i -pe"s/name\s+=\s+\'libinjection\'/name = \'${PACKAGE_NAME}\'/g" libinjection/python/setup.py
perl -i -pe"s/url\s+=.+,/url = \'https:\/\/github.com\/sqreen\/libinjection-build-python\',/g" libinjection/python/setup.py
perl -i -pe"s/version\s+=.+,/version = '${VERSION}',/g" libinjection/python/setup.py
