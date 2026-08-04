#!/usr/bin/env bash
# generate protoc code and publish it to appropriate repositories.

set -euo pipefail

workdirs=(gen go-genproto py-genproto openapi-genproto)

# clean up on the way out, and again up front in case a previous run was
# killed before its trap could fire. The paths are relative and the script
# runs from inside the clones, so return here before removing them.
startdir=$PWD
trap 'cd "${startdir}" && rm -rf "${workdirs[@]}"' EXIT
rm -rf "${workdirs[@]}"

protorev=$(git describe --always)

# generate all code
buf generate --template buf.gen.cobalt.yaml proto

# publish go code
git clone git@github.com:cobaltspeech/go-genproto
rm -rf go-genproto/{gw,cobaltspeech}
mv gen/go/{gw,cobaltspeech} go-genproto/
pushd go-genproto
go get -u ./...
go mod tidy
git add .
git diff --quiet HEAD || git commit -am "auto-update: proto=$protorev"
git push origin master
popd
rm -rf go-genproto

# publish python code
git clone git@github.com:cobaltspeech/py-genproto
rm -rf py-genproto/cobaltspeech
mv gen/py/cobaltspeech py-genproto/
pushd py-genproto
find cobaltspeech -type d -exec touch {}/__init__.py \;
git add .
git diff --quiet HEAD || git commit -am "auto-update: proto=$protorev"
git push origin master
popd
rm -rf py-genproto

# publish the openapi v2 docs
git clone git@github.com:cobaltspeech/openapi-genproto
rm -rf openapi-genproto/cobaltspeech
mv gen/openapi-docs/cobaltspeech openapi-genproto/
pushd openapi-genproto
git add .
git diff --quiet HEAD || git commit -am "auto-update: proto=$protorev"
git push origin master
popd
rm -rf openapi-genproto
