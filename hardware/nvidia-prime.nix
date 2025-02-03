{
  imports = [ ./nvidia.nix ];
  hardware.nvidia = {
    powerManagement.finegrained = true;
    prime.offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };
}
