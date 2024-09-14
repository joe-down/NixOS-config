{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, nixos-hardware, ... }:
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

      homeManager = [ home-manager.nixosModules.home-manager ];

      defaultConfig = extraModules:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = homeManager ++ extraModules;
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
    };
}
