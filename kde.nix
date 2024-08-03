{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  home-manager.users.joe = { pkgs, ... }: {
    home.packages = with pkgs; [
      kate
      yakuake
      kile
      sddm-kcm
      kmail
      kcalc
      filelight
      ksystemlog
      kompare
      ktorrent
      kget
      kile
      discover
      aspellDicts.en
      aspellDicts.en-computers
      xwaylandvideobridge
    ];
  };
}
