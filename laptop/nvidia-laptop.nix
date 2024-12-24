{ lib, ... }: {
  imports = [ ../hardware/nvidia-prime.nix ];
  hardware.nvidia.open = lib.mkForce false;
}
