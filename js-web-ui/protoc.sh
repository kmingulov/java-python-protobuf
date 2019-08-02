#!/bin/bash

PROTOGEN=./node_modules/.bin/protoc-gen-ts
OUT_DIR=./src/proto

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

protoc \
        -I ../proto/ \
        --plugin="protoc-gen-ts=$PROTOGEN" \
        --js_out="import_style=commonjs,binary:${OUT_DIR}" \
        --ts_out="${OUT_DIR}" \
        ../proto/*.proto
