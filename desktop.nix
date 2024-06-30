{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./common.nix
      ./kde.nix
      ./amd_cpu.nix
    ];

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

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    nvidiaPersistenced = true;
  };

 swapDevices = [ {
    device = "/swap/swapfile";
  } ];

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  programs.dconf.enable = true;
  #services.flatpak.enable = true;

  home-manager.users.joe = { pkgs, ... }: {
    programs.bash = {
      shellAliases = {
        "joe-import-roms" = "igir move zip test clean --dat /mnt/hdd/ROMs/DATs/ --input /mnt/hdd/ROMs/ROMs/ --input ./ --output /mnt/hdd/ROMs/ROMs/ --dir-dat-name";
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
      Audiobooks = {
        path = "/mnt/hdd/Audiobooks/";
      };
      Books = {
        path = "/mnt/hdd/Books/";
      };
      Comics = {
        path = "/mnt/hdd/Comics/";
      };
      Music = {
        path = "/mnt/hdd/Music/Music/";
      };
      ROMs = {
        path = "/mnt/hdd/ROMs/ROMs/";
      };
    };
  };
}
