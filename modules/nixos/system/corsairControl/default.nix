inputs@{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.system.custom.corsairControl;
in {
  options.system.custom.nvidiagpu = with types; {
    enable = mkBoolOpt false "Enable Corsair control software";
  };
  config = mkIf cfg.enable { hardware.ckb-next.enable = true; };
}
