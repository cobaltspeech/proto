#!/usr/bin/env bash
# format all proto files in the proto directory with buf format
nix-shell --run "buf format -w proto"
