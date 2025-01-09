{ config, lib, pkgs, ... }:

{
  environment.packages = with pkgs; [
    nano
    git
    gh
    (pkgs.python3.withPackages
      (python-pkgs: with python-pkgs; [ pybox2d pygame torch matplotlib tqdm ]))
    ffmpeg
    opencv4
    gnused
    openvscode-server
    nixfmt-classic
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  #time.timeZone = "Europe/Berlin";
}
