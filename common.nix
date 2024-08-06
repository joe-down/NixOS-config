{ config, pkgs, lib, ... }: {
  imports = [ ./core.nix ];

  boot.plymouth.enable = true;

  security.rtkit.enable = true;

  hardware = {
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    steam-hardware.enable = true;
  };

  networking.firewall = {
    enable = true;
    logReversePathDrops = true;
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

  services = {
    xserver = {
      enable = true;
      desktopManager.retroarch.enable = true;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    printing.enable = true;
  };

  programs = {
    virt-manager.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extest.enable = true;
    };
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = { general = { renice = 20; }; };
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        runAsRoot = true;
      };
    };
    waydroid.enable = true;
  };

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
      "libfprint-2-tod1-goodix"
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

  home-manager.users.joe = { pkgs, ... }: {
    services = {
      kdeconnect = {
        enable = true;
        indicator = true;
      };
      easyeffects.enable = true;
    };

    programs = {
      bash = {
        enable = true;
        shellAliases = {
          "joe-raspberrypi" = "ssh joe@joe-raspberrypi.local";
          "joe-rebuild-switch" = "sudo nixos-rebuild switch --upgrade-all";
          "joe-rebuild-boot" = "sudo nixos-rebuild boot --upgrade-all";
        };
      };
      firefox = {
        enable = true;
        profiles.joe = {
          isDefault = true;
          search = {
            default = "DuckDuckGo";
            force = true;
          };
        };
      };
      chromium.enable = true;
      obs-studio.enable = true;
      texlive = {
        enable = true;
        extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
      };
      mangohud = {
        enable = true;
        enableSessionWide = true;
        settings = { gamemode = true; };
      };
    };

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
      nixfmt-classic
      cmake
      gnumake
      gcc
      alsa-utils
      krita
      blender
      lutris
      heroic
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
  };
}
