{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.evince.enable = true;

  home-manager.users.joe = { pkgs, ... }: {
    home.packages = with pkgs; [
      gnome-latex
      gnome.gnome-software
      gnome-tweaks
      plots
      gnomeExtensions.appindicator
    ];

    services.kdeconnect = { package = pkgs.gnomeExtensions.gsconnect; };
  };
}
