{ config, pkgs, lib, ... }: {
  imports = [ ./core.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    plymouth.enable = true;
  };

  security.rtkit.enable = true;

  hardware = {
    alsa.enablePersistence = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    steam-hardware.enable = true;
    sensor.iio.enable = true;
  };

  networking.firewall = {
    enable = true;
    logReversePathDrops = true;
    #Hotspot DHCP server
    allowedUDPPorts = [ 67 ];
  };

  services = {
    #xserver.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    ollama.enable = true;
    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = false;
      package = pkgs.mullvad-vpn;
    };
  };

  programs = {
    virt-manager.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;
    };
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = { general = { renice = 20; }; };
    };
    kdeconnect.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    chromium = {
      enable = true;
      homepageLocation = "https://duckduckgo.com";
    };
    bash = {
      enableLsColors = true;
      completion.enable = true;
      shellAliases = { "joe-raspberrypi" = "ssh joe@joe-raspberrypi.local"; };
    };
    firefox = {
      enable = true;
      languagePacks = [ "en-GB" ];
      preferencesStatus = "locked";
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
      "steam-unwrapped"
      "spotify"
      "discord"
      "pycharm-professional"
      "clion"
      "webstorm"
      "idea-ultimate"
      "rider"
      "goland"
      "rust-rover"
      "minecraft-launcher"
      "osu-lazer-bin"
      "blender"
      "xow_dongle-firmware"
      "libfprint-2-tod1-goodix"
      #cuda
      "cuda_cudart"
      "cuda_cccl"
      "libnpp"
      "libcublas"
      "libcufft"
      "cuda_nvcc"
      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcurand"
      "libcusolver"
      "libnvjitlink"
      "libcusparse"
      "cudnn"
      #
    ];
  environment.systemPackages = with pkgs; [ wl-clipboard ];
  users.users.joe.packages = with pkgs; [
    spotify
    discord
    jetbrains.pycharm-professional
    jetbrains.clion
    cmake
    gcc
    jetbrains.webstorm
    jetbrains.idea-ultimate
    jetbrains.rider
    dotnet-sdk
    jetbrains.goland
    jetbrains.rust-rover
    bottles
    prismlauncher
    gimp
    #godot_4-mono
    libresprite
    bitwarden
    kdenlive
    nixfmt-classic
    alsa-utils
    krita
    inkscape-with-extensions
    blender
    heroic
    r2modman
    osu-lazer-bin
    gzdoom
    qzdl
    igir
    cemu
    ryujinx
    rpcs3
    ludusavi
    rclone
    libreoffice-still
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

  home-manager.users.joe = { pkgs, ... }: {
    services = { easyeffects.enable = true; };

    programs = {
      bash.enable = true;
      texlive = {
        enable = true;
        extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
      };
      mangohud = {
        enable = true;
        enableSessionWide = true;
        settings = {
          gamemode = true;
          ram = true;
          vram = true;
          show_fps_limit = true;
          swap = true;
          time = true;
          no_display = true;
          gpu_name = true;
        };
      };
    };
  };
}
