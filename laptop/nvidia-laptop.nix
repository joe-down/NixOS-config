{
  imports = [ ../hardware/nvidia-core.nix ];

  hardware.nvidia.powerManagement.finegrained = true;
  hardware.nvidia.open = false;
}
