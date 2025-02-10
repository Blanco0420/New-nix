{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.roles.lightweight;
in {
  options.roles.lightweight = with types; {
    enable = mkBoolOpt false "enable lightweight";
  };

  config = mkIf cfg.enable {
    system.custom = {
      desktop = {
        enable = true;
        environent = "xfce";
      };
    };
  };
}
