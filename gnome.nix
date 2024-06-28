{ config, pkgs, lib, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.evince.enable = true;

  home-manager.users.joe = { pkgs, ... }: {
    home.packages = with pkgs ; [
                      gnome-latex
                      gnome.gnome-software
                      gnome.gnome-tweaks
                      plots
                      gnomeExtensions.bluetooth-smart-lock
                    ];
  
    services.kdeconnect = {
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };
}
