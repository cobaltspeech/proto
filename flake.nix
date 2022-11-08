{
  description = "Flake for proto generation with buf";

  # repositories we are tracking
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let supportedSystems = [ "x86_64-linux" ];
    in utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        shellForPkgs = pkgs:
          pkgs.mkShell {
            buildInputs = with pkgs; [
              buf
              grpc
              grpc-gateway
              protobuf
              protoc-gen-go
              protoc-gen-go-grpc
            ];

          };
      in { devShells.default = shellForPkgs pkgs; });
}