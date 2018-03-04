#!/bin/bash

set -e

export ZIP_SRC_DIR=${ZIP_SRC_DIR:-/zip}
export GOBIN=${GOBIN:-main}
export ZIP_FILENAME=${ZIP_FILENAME:-function.zip}

echo "Constructing workspace..."
export FULL_PACKAGE=/go/src/${PACKAGE}
mkdir -p $(dirname ${FULL_PACKAGE})
ln -s /workdir ${FULL_PACKAGE}

export SUPPORTING_FILES_SRC=/workdir/supportingFiles
if [ -d "${SUPPORTING_FILES_SRC}" ] ; then
  echo "Copying supportingFiles"
  cp -r ${SUPPORTING_FILES_SRC} ${ZIP_SRC_DIR}
fi

echo "Building ..."
cd ${FULL_PACKAGE} && GOARCH="amd64" GOOS="linux" CGO_ENABLED=0 go build -tags="node ${FUNCTION}" -o "${ZIP_SRC_DIR}/${GOBIN}"

echo "Packagig ${ZIP_FILENAME}"
cd ${ZIP_SRC_DIR} && zip -r ${ZIP_FILENAME} main node_modules index.js package.json supportingFiles -x *build*

export ZIP_OUT_DIR=/output/${FUNCTION}
mkdir -p ${ZIP_OUT_DIR}
mv ${ZIP_FILENAME} ${ZIP_OUT_DIR}
