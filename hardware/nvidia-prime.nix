{
  imports = [ ./nvidia.nix ];
  hardware.nvidia = {
    powerManagement.enable = true;
    prime.offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };
}
