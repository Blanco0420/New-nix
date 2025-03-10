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
  cfg = config.user;
in
{
  options.user = with types; {
    name = mkOpt str "user" "The name of the user's account";
    initialPassword = mkOpt str "1234" "The initial password to use";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "Extra options passed to users.users.<name>";
  };

  config = {
    users.mutableUsers = true;
    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name initialPassword;
      home = "/home/${cfg.name}";
      group = "users";

      extraGroups = [
        "wheel"
        "audio"
        "sound"
        "video"
        "networkmanager"
        "input"
        "tty"
        "podman"
        "kvm"
        "libvirtd"
        "docker"
      ] ++ cfg.extraGroups;
    } // cfg.extraOptions;

    home-manager = {
      useGlobalPkgs = false;
      useUserPackages = true;
      # backupFileExtension = "backup";
    };

    # FIXME: Temporary
    users.users."blanco" = {
      extraGroups = [ "docker" ];
    };
  };
}
