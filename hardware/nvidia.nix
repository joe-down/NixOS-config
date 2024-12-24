{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      nvidiaPersistenced = true;
      powerManagement.enable = true;
    };
  };

  services = {
    xserver.videoDrivers = [ "nvidia" ];
    ollama.acceleration = "cuda";
  };
  nixpkgs.config.cudaSupport = true;
  nix.settings = {
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
