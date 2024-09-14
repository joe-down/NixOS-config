{ config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./laptop.nix ];
  system.stateVersion = "23.11";
  home-manager.users.joe = { pkgs, ... }: { home.stateVersion = "23.11"; };
}
