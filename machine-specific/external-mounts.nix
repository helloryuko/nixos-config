{
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-label/twizzy\\x20rich";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "nofail"
    ];
  };
}
