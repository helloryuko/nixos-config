{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  boot.kernelParams = [ "usbcore.autosuspend=60" ];
}
