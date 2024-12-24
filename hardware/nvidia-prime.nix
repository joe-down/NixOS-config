{
  imports = [ ./nvidia.nix ];
  hardware.nvidia = {
    powerManagement.finegrained = true;
    prime.offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };
  home-manager.users.joe.xdg.desktopEntries.steam = {
    name = "Steam";
    exec = "nvidia-offload steam %U";
    icon = "steam";
    categories = [ "Game" ];
  };
}
