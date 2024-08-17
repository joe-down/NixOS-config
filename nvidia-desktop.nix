{
  imports = [ ./nvidia-core.nix ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.open = true;
}
