{ inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "nix.original";
    extraSpecialArgs = { inherit inputs; };
  };

  imports = [ ./users.nix ];
}
