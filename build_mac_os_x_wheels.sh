set -e
set -x

cd libinjection/python
for PYVERSION in 2.7 3.4 3.5 3.6 3.7; do
    curl https://bootstrap.pypa.io/get-pip.py | python
    pip install virtualenv
    ORIG_PATH=$PATH
    PATH=/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
    virtualenv -p /Library/Frameworks/Python.framework/Versions/${PYVERSION}/bin/python${PYVERSION} venv_${PYVERSION}
    PATH=$ORIG_PATH
    . ./venv_${PYVERSION}/bin/activate
    make
    python setup.py bdist_wheel --verbose
    deactivate
done
cd ../..
cp -r libinjection/python/dist .
