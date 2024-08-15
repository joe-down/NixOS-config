{ pkgs, ... }: {
  imports = [
    <nixos-hardware/dell/xps/15-9500/nvidia>
    ./nvidia.nix
    ./intel_cpu.nix
    ./common.nix
    ./gnome.nix
  ];
  fileSystems = { "/".options = [ "compress=zstd" "discard=async" ]; };
  swapDevices = [{ device = "/swap/swapfile"; }];
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
  networking.hostName = "joe-laptop";
  services.thermald.enable = true;
  services.pipewire.wireplumber.extraConfig = {
    "10-disable-camera" = {
      "wireplumber.profiles" = {
        main = { "monitor.libcamera" = "disabled"; };
      };
    };
  };
  powerManagement.powertop.enable = true;
  hardware.nvidia.powerManagement.finegrained = true;
}
