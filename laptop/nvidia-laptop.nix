{
  imports = [ ../hardware/nvidia.nix ];

  hardware.nvidia.powerManagement.finegrained = true;
  hardware.nvidia.open = false;
}
