{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    http-connections = 128;
    max-substitution-jobs = 128;
    max-jobs = "auto";
  };

  # Lix is a custom implementation of Nix that is
  # a little bit faster.
  nix.package = pkgs.lixPackageSets.stable.lix;

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
}
