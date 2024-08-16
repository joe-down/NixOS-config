{
  imports = [ ./common.nix ./kde.nix ./amd_cpu.nix ./nvidia-desktop.nix ];

  fileSystems = {
    "/".options = [ "compress=zstd" "discard=async" ];
    "/mnt/ssd".options = [ "compress=zstd" "discard=async" ];
    "/mnt/hdd".options = [ "compress=zstd" ];
  };
  swapDevices = [{ device = "/swap/swapfile"; }];

  networking.hostName = "joe-desktop";

  hardware.xone.enable = true;

  programs.dconf.enable = true;

  systemd.user.services."loopback-line-in" = {
    script =
      "/run/current-system/sw/bin/pw-loopback --capture=alsa_input.usb-Generic_USB_Audio-00.HiFi_7_1__Line1__source";
    wantedBy = [ "pipewire.service" ];
    partOf = [ "pipewire.service" ];
    after = [ "easyeffects.service" ];
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
    };
    samba = {
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
  };

  home-manager.users.joe = { pkgs, ... }: {
    xdg.configFile = {
      "autostart/spotify.desktop".source = ./config/autostart/spotify.desktop;
      "autostart/discord.desktop".source = ./config/autostart/discord.desktop;
      "autostart/steam.desktop".source = ./config/autostart/steam.desktop;
      "autostart/openrgb.desktop".source = ./config/autostart/openrgb.desktop;
    };
    programs = {
      bash.shellAliases = {
        "joe-import-roms" =
          "igir move zip test clean --dat /mnt/hdd/ROMs/DATs/ --input /mnt/hdd/ROMs/ROMs/ --input ./ --output /mnt/hdd/ROMs/ROMs/ --dir-dat-name";
      };
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
