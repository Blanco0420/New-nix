{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.roles.desktop;
in
{
  options.roles.desktop = with types; {
    enable = mkBoolOpt false "enable desktop role";
  };

  config = mkIf cfg.enable {
    apps.firefox.enable = true;
    home.packages = with pkgs; [
      wl-clipboard
      ulauncher
      kdePackages.spectacle
    ];

    #Audio stuff
    services.pulseeffects.enable = true;
    dconf = {
      enable = true;
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          headsetcontrol.extensionUuid
          open-bar.extensionUuid
          tiling-shell.extensionUuid

          gsconnect.extensionUuid
        ];
      };
    };
  };
}
