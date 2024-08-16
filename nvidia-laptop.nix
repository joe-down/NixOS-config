{
  imports = [ ./nvidia-core.nix ];

  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
    powerManagement.finegrained = true;
  };
}
