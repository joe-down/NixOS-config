{ pkgs, ... }: {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.evince.enable = true;
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  programs.firefox.nativeMessagingHosts.packages =
    [ pkgs.gnomeExtensions.gsconnect ];

  users.users.joe.packages = with pkgs; [
    enter-tex
    gnome-software
    gnome-tweaks
    plots
    gnomeExtensions.appindicator
  ];
}
