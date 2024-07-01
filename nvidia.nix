{ config, pkgs, lib, ... }:

{
  nixpkgs.config.cudaSupport = true;
}
