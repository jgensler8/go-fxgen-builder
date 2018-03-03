#!/bin/bash

export OUTDIR=${OUTDIR:-/zip}
export GOBIN=${GOBIN:-main}
export OUT=${OUT:-function.zip}

echo "Constructing workspace..."
export FULL_PACKAGE=/go/src/${PACKAGE}
mkdir -p $(dirname ${FULL_PACKAGE})
ln -s /workdir ${FULL_PACKAGE}

echo "Building ..."
GOARCH="amd64" GOOS="linux" CGO_ENABLED=0 go build -tags node -tags "${FUNCTION}" -o "${OUTDIR}/${GOBIN}"
cd /zip && zip -r ${OUT} main node_modules index.js package.json -x *build*

export ZIP_OUT_DIR=/output/${FUNCTION}
mkdir -p ${ZIP_OUT_DIR}
mv function.zip ${ZIP_OUT_DIR}
