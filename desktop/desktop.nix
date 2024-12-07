{ pkgs, ... }: {
  imports = [
    ../common/common.nix
    ../kde/kde.nix
    ../hardware/amd_cpu.nix
    ../hardware/nvidia-core-open.nix
  ];

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
    pipewire.extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = { "default.clock.rate" = 192000; };
      };
    };
    hardware.openrgb = {
      enable = true;
      motherboard = "amd";
      package = pkgs.openrgb-with-all-plugins;
    };
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        Audiobooks = { path = "/mnt/hdd/Audiobooks/"; };
        Books = { path = "/mnt/hdd/Books/"; };
        Comics = { path = "/mnt/hdd/Comics/"; };
        Music = { path = "/mnt/hdd/Music/Music/"; };
        ROMs = { path = "/mnt/hdd/ROMs/ROMs/"; };
      };
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
      "autostart/spotify.desktop".source = ./config/autostart/spotify.desktop;
      "autostart/discord.desktop".source = ./config/autostart/discord.desktop;
      "autostart/steam.desktop".source = ./config/autostart/steam.desktop;
      "autostart/openrgb.desktop".source = ./config/autostart/openrgb.desktop;
      "gzdoom/gzdoom.ini".text = ''
        [IWADSearch.Directories]
        Path=/mnt/hdd/steam/steamapps/common/Ultimate Doom/rerelease/'';
    };
    programs = {
      beets = {
        enable = true;
        settings = {
          directory = "/mnt/hdd/Music/Music/";
          library = "/mnt/hdd/Music/Beets/musiclibrary.db";
          plugins = "chroma fetchart mbsync web";
        };
      };
    };
  };
}
