{ pkgs, ... }:

{
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

  services.udev.packages = [ pkgs.opentabletdriver ];
  # hardware.opentabletdriver.enable = true;
}
