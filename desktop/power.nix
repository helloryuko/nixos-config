{
  services.power-profiles-daemon.enable = true;
  services.upower = {
    enable = true;
    allowRiskyCriticalPowerAction = true;
    criticalPowerAction = "Ignore";
  };
}
