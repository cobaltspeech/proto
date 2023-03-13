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
            name = "proto";
            buildInputs = with pkgs; [
              buf
              protoc-gen-doc
              git
            ];

            shellHook = ''
              export GOPROXY="http://goproxy.in.cobaltspeech.com"
              export GONOSUMDB="github.com/cobaltspeech/*"
            '';

          };
      in { devShells.default = shellForPkgs pkgs; });
}
