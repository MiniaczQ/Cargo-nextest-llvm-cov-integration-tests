#!/bin/sh

set -e
. ./envvars.sh
rm -r /app/target
cargo nextest run --archive-file test.tar.zst --extract-to /app --verbose --profile ci
cargo llvm-cov report --cobertura > /app/result/cobertura.xml
