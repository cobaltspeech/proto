#!/usr/bin/env bash
# generate protoc code and publish it to appropriate repositories.

set -euo pipefail

# cleanup before generation, just in case.
rm -rf gen

protorev=$(git describe --always)

# generate all code
nix develop -c buf generate proto

# publish go code
git clone git@github.com:cobaltspeech/go-genproto
rm -rf go-genproto/{gw,cobaltspeech}
mv gen/go/{gw,cobaltspeech} go-genproto/
pushd go-genproto
go get -u ./...
go mod tidy
git diff --quiet HEAD || git commit -am "auto-update: proto=$protorev"
git push origin master
popd
rm -rf go-genproto

# cleanup generated code
rm -rf gen
