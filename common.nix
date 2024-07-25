{ config, pkgs, lib, ... }:

{
  imports = [ ../hardware-configuration.nix <home-manager/nixos> ];

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
      "osu-lazer-bin"
      "blender"
      "xow_dongle-firmware"
      # cuda
      "cuda_cudart"
      "cuda_cccl"
      "libnpp"
      "libcublas"
      "libcufft"
      "cuda_nvcc"
      "cuda_cupti"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "libcurand"
      "libcusolver"
      "libnvjitlink"
      "libcusparse"
      "cudnn"
      "cuda_profiler_api"
      "cuda_nvprof"
      "libcutensor"
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
    extraGroups = [ "networkmanager" "wheel" "gamemode" "dialout" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.joe = { pkgs, ... }: {
    home.packages = with pkgs; [
      spotify
      discord
      jetbrains.pycharm-professional
      jetbrains.clion
      jetbrains.webstorm
      jetbrains.idea-ultimate
      bottles
      #minecraft
      gimp
      godot_4
      (pkgs.python3.withPackages
        (python-pkgs: [ python-pkgs.numpy python-pkgs.cupy python-pkgs.torch ]))
      bitwarden
      kdenlive
      # Other
      krita
      blender
      micromamba
      lutris
      heroic
      mangohud
      r2modman
      osu-lazer-bin
      igir
      vlc
      (retroarch.override {
        cores = with libretro; [
          dolphin
          melonds
          desmume
          mupen64plus
          parallel-n64
          mgba
          citra
          ppsspp
          play
          swanstation
          beetle-psx-hw
        ];
      })
    ];

    xdg.configFile."MangoHud/MangoHud.conf".source = ./config/MangoHud.conf;
    xdg.configFile."gamemode.ini".source = ./config/gamemode.ini;

    programs.bash = {
      enable = true;
      shellAliases = {
        "joe-raspberrypi" = "ssh joe@joe-raspberrypi.local";
        "joe-rebuild-switch" = "sudo nixos-rebuild switch --upgrade-all";
        "joe-rebuild-boot" = "sudo nixos-rebuild boot --upgrade-all";
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

    programs.chromium = { enable = true; };

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

    services.easyeffects = { enable = true; };

    programs.obs-studio = {
      enable = true;
      plugins = [ ];
    };

    programs.texlive = {
      enable = true;
      extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ ];

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

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extest.enable = true;
    package = pkgs.steam.override { extraEnv = { MANGOHUD = true; }; };
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
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    } # kdeconnect
      ];
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    } # kdeconnect
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

  xdg.portal.enable = true;
  services.xserver.desktopManager.retroarch = { enable = true; };
  nix.settings.auto-optimise-store = true;
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flags = [ "--upgrade-all" ];
  };
}
