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
  cfg = config.roles.laptop;
in
{
  options.roles.laptop = with types; {
    enable = mkBoolOpt false "enable ROG laptop stuff";
  };

  config = mkIf cfg.enable {
    system.custom = {
      nvidiagpu.enable = true;
      bluetooth.enable = true;
      battery.enable = true;
    };
    programs = {
      rog-control-center = {
        enable = true;
        autoStart = true;
      };
    };
  };
}