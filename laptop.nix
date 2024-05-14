{ config, pkgs, lib, ... }:

{
  imports =
    [
      <nixos-hardware/dell/xps/15-9500/nvidia>
      ./common.nix
      ./gnome.nix
    ];
    
  boot.initrd.luks.devices."luks-f14f0478-5671-497b-9d7f-cbab653ee2ac".device = "/dev/disk/by-uuid/f14f0478-5671-497b-9d7f-cbab653ee2ac";
  
  networking.hostName = "joe-laptop";
  
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
      charger = {
       governor = "performance";
       turbo = "auto";
      };
    };
  };
}
