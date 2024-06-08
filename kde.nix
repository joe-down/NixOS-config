{ config, pkgs, lib, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  
  home-manager.users.joe = { pkgs, ... }: {
    home.packages = [
                      pkgs.kate
                      pkgs.yakuake
                      pkgs.kile
                      pkgs.qpwgraph
                      pkgs.sddm-kcm
                      pkgs.kmail
                      pkgs.kcalc
                      pkgs.filelight
                      pkgs.ksystemlog
                      pkgs.kompare
                      pkgs.ktorrent
                      pkgs.kget
                      pkgs.kile
                      pkgs.discover
                    ];
  };
}
