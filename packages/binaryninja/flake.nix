# Sophie: adapted from https://github.com/msanft/ida-pro-overlay, an MIT-licensed project.
# Included as an example on how to package your own flake and include it in your system.
{
  description = "Nix flake for Binary Ninja Personal";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      overlays.default = self: super: {
        # use super here to inherit allowUnfree status
        binaryninja = super.callPackage ./binaryninja.nix {};
      };
      packages.${system}.binaryninja = pkgs.callPackage ./binaryninja.nix {};
    };
}
