{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    broadcom-bt-firmware
  ];

  hardware.enableRedistributableFirmware = true;
}
