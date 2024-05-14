{ config, pkgs, lib, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  home-manager.users.joe = { pkgs, ... }: {
    home.packages = [
                      pkgs.gnome-latex
                    ];
  
    services.kdeconnect = {
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };
}
