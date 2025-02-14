{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.roles.desktop;
in {
  options.roles.desktop = with types; {
    enable = mkBoolOpt false "enable desktop role";
  };

  config = mkIf cfg.enable {
    apps.firefox.enable = true;
    home.packages = with pkgs; [ wl-clipboard ];

    #Audio stuff
    services.pulseeffects.enable = true;
  };
}
