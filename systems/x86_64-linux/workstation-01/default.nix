{ lib, pkgs, ... }:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./secrets/secrets.nix
  ];

  networking.hostName = "workstation-01";
  
    roles = {
      common.enable = true;
      desktop.enable = true;
      gaming.enable = true;
    };

  boot = {
    supportedFilesystems = lib.mkForce ["btrfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    resumeDevice = "/dev/disk/by-label/nixos";
  };


    system.stateVersion = "24.05";
  }
