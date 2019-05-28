#!/bin/bash
set -e
set -x

CONT=$(date +%s)

docker run \
    -d \
    --name ${CONT} quay.io/pypa/manylinux1_x86_64 bash \
    -c "mkdir /${BASE_PATH}; tail -f /var/log/lastlog"

docker cp . ${CONT}:${BASE_PATH}

docker exec ${CONT} bash -c "source multibuild/library_builders.sh && build_swig"

## Install SWIG

for PYVERSION in cp27-cp27m  cp34-cp34m cp35-cp35m cp36-cp36m cp37-cp37m
do
    PYTHON_PATH="/opt/python/${PYVERSION}/bin"
    docker exec ${CONT} bash -c "cd libinjection/python && ${PYTHON_PATH}/pip install virtualenv"
    docker exec ${CONT} bash -c "cd libinjection/python && ${PYTHON_PATH}/virtualenv --python=${PYTHON_PATH}/python venv"
    docker exec ${CONT} bash -c "cd libinjection/python && source venv/bin/activate && make"
    docker exec ${CONT} bash -c "cd libinjection/python && source venv/bin/activate && python setup.py bdist_wheel"
done

docker exec ${CONT} bash -c 'for i in $(ls libinjection/python/dist/*.whl); do auditwheel repair $i -w tmpdist; done;'
docker exec ${CONT} bash -c "rm libinjection/python/dist/*.whl"
docker exec ${CONT} bash -c "mkdir dist"
docker exec ${CONT} bash -c "cp tmpdist/*.whl dist"
docker exec ${CONT} bash -c "rm -rf tmpdist"

docker exec ${CONT} tar cvzf wheels.tar.gz dist/
docker cp ${CONT}:wheels.tar.gz .
tar xvf wheels.tar.gz
rm wheels.tar.gz

docker rm -f ${CONT}

