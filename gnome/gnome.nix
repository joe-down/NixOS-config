{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.evince.enable = true;
  programs.kdeconnect.package = gnomeExtensions.gsconnect;
  programs.firefox.nativeMessagingHosts.gsconnect = true;

  home-manager.users.joe = { pkgs, ... }: {
    home.packages = with pkgs; [
      gnome-latex
      gnome.gnome-software
      gnome.gnome-tweaks
      plots
      gnomeExtensions.appindicator
    ];
  };
}
