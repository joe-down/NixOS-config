{ config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./NixOS-config/.nix ];
  system.stateVersion = "";
  home-manager.users.joe = { pkgs, ... }: { home.stateVersion = ""; };
}
