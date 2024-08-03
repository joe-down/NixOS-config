{ config, pkgs, lib, ... }:

{
  imports = [ ./common.nix ./kde.nix ./amd_cpu.nix ./nvidia.nix ];

  networking.hostName = "joe-desktop"; # Define your hostname.

  fileSystems = {
    "/".options = [ "compress=zstd" "discard=async" ];
    "/mnt/ssd".options = [ "compress=zstd" "discard=async" ];
    "/mnt/hdd".options = [ "compress=zstd" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.xone.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    nvidiaPersistenced = true;
  };

  swapDevices = [{ device = "/swap/swapfile"; }];

  services.pipewire.extraConfig.pipewire = {
    "10-clock-rate" = {
      "context.properties" = { "default.clock.rate" = 192000; };
    };
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  programs.dconf.enable = true;

  home-manager.users.joe = { pkgs, ... }: {
    xdg.configFile."autostart/spotify.desktop".source =
      ./config/autostart/spotify.desktop;
    xdg.configFile."autostart/discord.desktop".source =
      ./config/autostart/discord.desktop;
    xdg.configFile."autostart/steam.desktop".source =
      ./config/autostart/steam.desktop;
    xdg.configFile."autostart/openrgb.desktop".source =
      ./config/autostart/openrgb.desktop;
    programs.bash = {
      shellAliases = {
        "joe-import-roms" =
          "igir move zip test clean --dat /mnt/hdd/ROMs/DATs/ --input /mnt/hdd/ROMs/ROMs/ --input ./ --output /mnt/hdd/ROMs/ROMs/ --dir-dat-name";
      };
    };

    programs.beets = {
      enable = true;
      settings = {
        directory = "/mnt/hdd/Music/Music/";
        library = "/mnt/hdd/Music/Beets/musiclibrary.db";
        plugins = "chroma fetchart mbsync web";
      };
    };
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    shares = {
      Audiobooks = { path = "/mnt/hdd/Audiobooks/"; };
      Books = { path = "/mnt/hdd/Books/"; };
      Comics = { path = "/mnt/hdd/Comics/"; };
      Music = { path = "/mnt/hdd/Music/Music/"; };
      ROMs = { path = "/mnt/hdd/ROMs/ROMs/"; };
    };
  };
}
