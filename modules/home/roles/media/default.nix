{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.roles.media;
in {
  options.roles.media = with types; {
    enable = mkBoolOpt false "enable media role";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ vlc spotify ]; };
}
