{
  imports = [ ../hardware/nvidia-prime.nix ];
  hardware.nvidia.prime = {
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:19:0:0";
  };
}
