{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.roles.gamingLaptop;
in {
  options.roles.gamingLaptop = with types; {
    enable = mkBoolOpt false "nixos desktop configuration.";
  };

  config = mkIf cfg.enable {
    system.custom = {
      desktop = {
        enable = true;
        environent = "kde";
      };
      corsairControl.enable = true;
      nvidiagpu.enable = true;
    };
    programs = {
      rog-control-center = {
        enable = true;
        autoStart = true;
      };
    };
  };
}
