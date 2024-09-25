{ pkgs, ... }: {
  imports = [
    ./nvidia-laptop.nix
    ../hardware/intel_cpu.nix
    ../common/common.nix
    ../gnome/gnome.nix
  ];
  fileSystems = { "/".options = [ "compress=zstd" "discard=async" ]; };
  swapDevices = [{ device = "/swap/swapfile"; }];
  services.fprintd = {
    enable = false;
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
}
