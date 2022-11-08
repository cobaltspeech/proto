#!/usr/bin/env bash
# format all proto files in the proto directory with buf format
nix develop -c buf format -w proto
