{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-droid.url = "nixpkgs/nixos-24.05";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-droid";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, lanzaboote
    , nixos-hardware, nixpkgs-droid, nix-on-droid, ... }:
    let
      secureBoot = [
        lanzaboote.nixosModules.lanzaboote
        ({ pkgs, lib, ... }: {
          environment.systemPackages = [ pkgs.sbctl ];
          boot.loader.systemd-boot.enable = lib.mkForce false;
          boot.lanzaboote = {
            enable = true;
            pkiBundle = "/etc/secureboot";
          };
        })
      ];

      defaultConfig = extraModules:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                    config.allowUnfreePredicate = pkg:
                      builtins.elem (final.lib.getName pkg) [
                        "cuda_cudart"
                        "libcublas"
                        "cuda_cccl"
                        "cuda_nvcc"
                      ];
                  };
                })
              ];
            }
          ] ++ extraModules;
        };
    in {
      nixosConfigurations = {
        joe-desktop =
          defaultConfig ([ ./desktop/configuration.nix ] ++ secureBoot);
        joe-laptop = defaultConfig ([
          ./laptop/configuration.nix
          nixos-hardware.nixosModules.dell-xps-15-9500-nvidia
        ] ++ secureBoot);
      };
      nixOnDroidConfigurations.default =
        nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import nixpkgs-droid {
            system = "aarch64-linux";
            config.allowUnfreePredicate = pkg:
              builtins.elem (nixpkgs-droid.lib.getName pkg) [ ];
          };
          modules = [ ./android/android.nix ];
        };
    };
}
