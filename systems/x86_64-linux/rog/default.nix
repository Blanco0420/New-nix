{ lib, pkgs, ... }:
{
  imports = [
    # ./disko.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "rog";

  roles = {
    common.enable = true;
    gaming.enable = true;
    laptop.enable = true;
  };
  system.custom = {
    corsairControl.enable = true;
    gpu.nvidia.enable = true;
    desktop = {
      enable = true;
      gnome = true;
    };
  };
  programs = {
    rog-control-center = {
      enable = true;
      autoStart = true;
    };
  };
  services.custom.kdeconnect.enable = true;
  # services.custom.kdeconnect.enable = true;

  # boot = {
  #   # supportedFilesystems = lib.mkForce ["btrfs"];
  #   kernelPackages = pkgs.linuxPackages_latest;
  #   resumeDevice = "/dev/disk/by-label/nixos";
  # };

  system.stateVersion = "24.05";
}
