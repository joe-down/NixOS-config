# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../hardware-configuration.nix
      <home-manager/nixos>
    ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "steam"
      "steam-original"
      "steam-run"
      "spotify"
      "discord"
      "pycharm-professional"
      "clion"
      "webstorm"
      "idea-ultimate"
      "minecraft-launcher"
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  
  services.fwupd.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "gb";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joe = {
    isNormalUser = true;
    description = "Joe";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.joe = { pkgs, ... }: {
    home.packages = [
                      pkgs.spotify
                      pkgs.discord
                      pkgs.jetbrains.pycharm-professional
                      pkgs.jetbrains.clion
                      pkgs.jetbrains.webstorm
                      pkgs.jetbrains.idea-ultimate
                      pkgs.bottles
                      # pkgs.minecraft
                      pkgs.gimp
                      pkgs.godot_4
                      pkgs.python3
                      pkgs.bitwarden
                      # kdenlive
                      pkgs.kdenlive
                      pkgs.glaxnimate
                      # Other
                      pkgs.krita
                      pkgs.blender
                      pkgs.micromamba
                      pkgs.lutris
                      pkgs.heroic
                      pkgs.igir
                      (pkgs.retroarch.override {
                        cores = with pkgs.libretro; [
                          dolphin
                          melonds
                          desmume
                          mupen64plus
                          parallel-n64
                          mgba
                          citra
                          ppsspp
                          play
                        ];
                      })
                    ];

    programs.bash = {
      enable = true;
      shellAliases = {
        "raspberrypi" = "ssh joe@joe-raspberrypi.local";
        "upgrade-system" = "sudo nixos-rebuild switch --upgrade-all";
      };
    };
    
    programs.firefox = {
      enable = true;
      profiles.joe = {
        isDefault = true;
        search = {
                   default = "DuckDuckGo";
                   force = true;
                 };
      };
    };
    
    programs.chromium = {
      enable = true;
    };

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    programs.git = {
      enable = true;
      userEmail = "30624504+joe-down@users.noreply.github.com";
      userName = "Joe";
    };
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    services.easyeffects = {
      enable = true;
    };

    programs.obs-studio = {
      enable = true;
      plugins = [];
    };
    
    programs.texlive = {
      enable = true;
    };
    
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
  };

  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
      };
      extraLibraries = p: with p; [
        mangohud
      ];
    };
  };
  hardware.steam-hardware.enable = true;

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking.firewall = {
   enable = true;
   # if packets are still dropped, they will show up in dmesg
   logReversePathDrops = true;
   # wireguard trips rpfilter up
   extraCommands = ''
     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
   '';
   extraStopCommands = ''
     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
   '';
   allowedTCPPortRanges = [
     { from = 1714; to = 1764; } # kdeconnect
   ];
   allowedUDPPortRanges = [
     { from = 1714; to = 1764; } # kdeconnect
   ];
  };

  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
      runAsRoot = true;
    };
  };
  virtualisation.waydroid.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  services.xserver.desktopManager.retroarch = {
    enable = true;
  };
}
