{ lib, pkgs, ... }: {
  imports = [
    # ./disko.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "chromebook";

  roles = {
    common.enable = true;
    laptop.enable = true;
    lightweight.enable = true;
  };

  # boot = {
  #   # supportedFilesystems = lib.mkForce ["btrfs"];
  #   kernelPackages = pkgs.linuxPackages_latest;
  #   resumeDevice = "/dev/disk/by-label/nixos";
  # };

  system.stateVersion = "24.05";
}
