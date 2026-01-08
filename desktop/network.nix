{
  networking.networkmanager.enable = true;

  # Makes huge boot time delays. Not sure why it even exists.
  systemd.services.NetworkManager-wait-online.enable = false;
}
