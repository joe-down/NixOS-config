{ config, pkgs, lib, ... }:

{
  imports = [
    <nixos-hardware/dell/xps/15-9500/nvidia>
    ./nvidia.nix
    ./intel_cpu.nix
    ./common.nix
    ./gnome.nix
  ];
  swapDevices = [{ device = "/swap/swapfile"; }];
  networking.hostName = "joe-laptop";
}
