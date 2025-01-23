{ pkgs, ... }: {
  imports = [ ../common/common.nix ../kde/kde.nix ./nvidia-desktop.nix ];

  fileSystems = {
    "/".options = [ "compress=zstd" "discard=async" ];
    "/mnt/ssd".options = [ "compress=zstd" "discard=async" ];
    "/mnt/hdd".options = [ "compress=zstd" ];
  };
  swapDevices = [{ device = "/swap/swapfile"; }];

  networking.hostName = "joe-desktop";

  hardware.xone.enable = true;

  programs.dconf.enable = true;
  programs.bash.shellAliases = {
    "joe-import-roms" =
      "igir move zip test clean --dat /mnt/hdd/ROMs/DATs/ --input /mnt/hdd/ROMs/ROMs/ --input ./ --output /mnt/hdd/ROMs/ROMs/ --dir-dat-name";
  };

  services = {
    hardware.openrgb = {
      enable = true;
      motherboard = "amd";
      package = pkgs.openrgb-with-all-plugins;
    };
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };

  home-manager.users.joe = { pkgs, ... }: {
    xdg.configFile = {
      "gzdoom/gzdoom.ini".text = ''
        [IWADSearch.Directories]
        Path=/mnt/hdd/steam/steamapps/common/Ultimate Doom/rerelease/'';
    };
  };
}
