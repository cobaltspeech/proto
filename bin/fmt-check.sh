#!/usr/bin/env bash
# check if all proto files are correctly formatted
buf format --exit-code proto >/dev/null || (
    echo "proto files not correctly formatted. please run bin/fmt.sh"
    exit 1
)
