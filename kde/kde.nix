{ pkgs, ... }: {
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  programs.chromium.enablePlasmaBrowserIntegration = true;

  users.users.joe.packages = with pkgs; [
    kdePackages.kate
    kdePackages.yakuake
    kdePackages.sddm-kcm
    kdePackages.kmail
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.ksystemlog
    #kdePackages.kompare
    kdePackages.ktorrent
    kdePackages.kget
    kdePackages.discover
    kile
    aspellDicts.en
    aspellDicts.en-computers
    xwaylandvideobridge
  ];
}
