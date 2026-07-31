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
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells = {
          # everything needed to generate and publish the code
          default = pkgs.mkShell {
            name = "proto";
            buildInputs = with pkgs; [ buf git go protoc-gen-doc grpc-gateway ];
          };

          # just enough to run the format, lint and breaking checks
          ci = pkgs.mkShell {
            name = "proto-ci";
            buildInputs = with pkgs; [ buf git ];
          };
        };
      });
}
