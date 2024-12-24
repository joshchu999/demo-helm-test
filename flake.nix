{
  description = "Development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = 
          with pkgs; 
          mkShell {
            packages = [ 
              direnv
              nix-direnv

              gitAndTools.pre-commit

              kubernetes-helm
            ];
          };
      }
    );
}
