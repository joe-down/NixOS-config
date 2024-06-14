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

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
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

  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0 # soundblaster crackle fix
  '';

  home-manager.users.joe = { pkgs, ... }: {
    programs.bash = {
      shellAliases = {
        "import-roms" = "git -C /mnt/hdd/ROMs/libretro-database/ pull && igir move zip test clean --dat /mnt/hdd/ROMs/libretro-database/metadat/*{redump,no-intro}*/ --input /mnt/hdd/ROMs/ROMs/ --input ./ --output /mnt/hdd/ROMs/ROMs/ --dir-dat-name";
      };
    };

    programs.beets = {
      enable = true;
      settings = {
        directory = "/mnt/hdd/Music/Music/";
        library = "/mnt/hdd/Music/Beets/musiclibrary.db";
      };
    };
  };
}
