# get the latest dependencies from "unstable" (latest master commit that has tested packages)
# this allows us to use the very latest packages for doing our builds.
{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz") { } }:

let
  protoc-gen-grpc-gateway = pkgs.buildGoModule rec {
    pname = "protoc-gen-grpc-gateway";
    version = "2.10.3";

    src = pkgs.fetchFromGitHub {
      owner = "grpc-ecosystem";
      repo = "grpc-gateway";
      rev = "v${version}";
      sha256 = "sha256-4/iE+sK+ZbG6194i8E1ZHla/7C9blKGRHwM7iX7nvXU=";
    };

    vendorSha256 = "sha256-FhiTU9VmDZNCPBWrmCqmQo/kPdDe8Da1T2E06CVN2kw=";

    subPackages = [ "protoc-gen-grpc-gateway" ];

  };

in pkgs.mkShell {
  buildInputs = with pkgs; [
    buf
    grpc
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    protoc-gen-grpc-gateway
  ];
}
