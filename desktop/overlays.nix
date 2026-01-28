{ inputs, ... }:

{
  # https://nixos-and-flakes.thiscute.world/nixpkgs/overlays
  nixpkgs.overlays = [
    inputs.ida-pro.overlays.default
    inputs.binaryninja.overlays.default
    inputs.nix-cachyos-kernel.overlays.default
  ];
}
