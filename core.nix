{
  imports = [ ../hardware-configuration.nix <home-manager/nixos> ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  console.keyMap = "uk";

  time.timeZone = "Europe/London";

  networking.networkmanager.enable = true;

  services = {
    xserver = {
      xkb.layout = "gb";
      xkb.variant = "";
    };
    fwupd.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };
  };

  nix.settings.auto-optimise-store = true;

  users.users.joe = {
    isNormalUser = true;
    description = "Joe";
    extraGroups = [ "networkmanager" "wheel" "gamemode" "dialout" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    users.joe = { pkgs, ... }: {
      programs = {
        git = {
          enable = true;
          userEmail = "30624504+joe-down@users.noreply.github.com";
          userName = "Joe";
        };
        gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };
      };
    };
  };
}