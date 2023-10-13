#!/bin/sh

set -e
set -o allexport
. ./envvars.sh
rm -r /app/target
cargo nextest run --archive-file test.tar.zst --extract-to /app --verbose
cargo llvm-cov report --cobertura
