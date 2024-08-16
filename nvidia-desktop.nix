{
  imports = [ ./nvidia-core.nix ];

  services.xserver.videoDrivers = [ "nvidia" ];
}
