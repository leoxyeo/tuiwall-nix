{
  description = "A Nix Flake for tuiwall - CLI wallpaper engine for the terminal";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.tuiwall = pkgs.callPackage ./package.nix { };
        packages.default = self.packages.${system}.tuiwall;

        apps.tuiwall = utils.lib.mkApp { drv = self.packages.${system}.tuiwall; };
        apps.default = self.apps.${system}.tuiwall;

        devShells.default = pkgs.mkShell {
          buildInputs = [ self.packages.${system}.tuiwall ];
        };
      }
    );
}
