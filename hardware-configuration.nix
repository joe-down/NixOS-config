# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6eedffc5-45b9-4a5a-a778-1ba545155267";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."nvme".device = "/dev/disk/by-uuid/672f212c-ec87-4702-9d10-a4886f94c9cc";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3F50-D4BB";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/mnt/ssd" =
    { device = "/dev/disk/by-uuid/3648e136-09cc-428c-ad28-d2cd62da934b";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."ssd".device = "/dev/disk/by-uuid/2a83b74c-79b7-4e6b-9fec-b69c491f71d7";

  fileSystems."/mnt/hdd" =
    { device = "/dev/disk/by-uuid/d84ab174-c25b-4f56-ae87-70a6b79a4065";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."hdd".device = "/dev/disk/by-uuid/ee70882b-0872-4d5c-aef5-4836ae1d5b9f";

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.gb-lon-wg-001.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp10s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}