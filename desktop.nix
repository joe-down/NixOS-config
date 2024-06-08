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
    device = "/var/lib/swapfile";
    size = 64*1024;
  } ];

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  programs.dconf.enable = true;
}
