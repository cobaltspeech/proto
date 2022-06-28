# get the latest dependencies from "unstable" (latest master commit that has tested packages)
# this allows us to use the very latest packages for doing our builds.
{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    buf
    grpc
    grpc-gateway
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
  ];
}
