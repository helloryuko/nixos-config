{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
  };

  # For trash folder in explorer
  services.gvfs.enable = true;

  # For thumbnails in Thunar
  services.tumbler.enable = true;

  # CLI tools that will be available for any user.
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
  ];
}
