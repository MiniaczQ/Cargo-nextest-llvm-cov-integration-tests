#!/bin/sh

set -e
. ./envvars.sh && cargo nextest run --archive-file test.tar.zst
. ./envvars.sh && cargo llvm-cov report --html
