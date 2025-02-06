{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.system.custom.boot;
in
{
  options.system.custom.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting.";
  };

  config = mkIf cfg.enable {
    # boot.loader = {
    #   systemd-boot = {
    #     enable = true;
    #     configurationLimit = 5;
    #     editor = false;
    #   };
    #   efi.canTouchEfiVariables = true;
    #   timeout = 5;
    # };
    boot.loader = {
  efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
  };
  grub = {
     efiSupport = true;
     useOSProber = true;
     #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
     device = "nodev";
  };
};

  };
}
