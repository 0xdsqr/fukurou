{
  description = "funtional library written in bun for research and development";
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs-unstable, nixpkgs-stable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
        pkgs-stable = import nixpkgs-stable { inherit system; };
      in {
        devShells = {
          default = pkgs-stable.mkShell {
            buildInputs = with pkgs-stable; [
              git
            ] ++ [
              pkgs-unstable.bun
            ];
            shellHook = ''
              echo "🟪 bingbong 🟪"
            '';
          };
        };
      });
}
