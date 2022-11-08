#!/usr/bin/env bash
# run buf linter over all proto files
nix develop -c buf lint proto || (
    echo "linter failed on some proto files."
    exit 1
)
