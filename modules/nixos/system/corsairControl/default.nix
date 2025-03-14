inputs@{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.system.custom.corsairControl;
in {
  options.system.custom.corsairControl = with types; {
    enable = mkBoolOpt false "Enable Corsair control software";
  };
  config = mkIf cfg.enable {
    hardware.ckb-next.enable = true;
    environment.systemPackages = with pkgs; [ ckb-next ];
  };
}
