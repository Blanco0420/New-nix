{ config, lib, ... }:

with lib;
let cfg = config.system.custom.tablet;
in {
  options.system.custom.tablet.enable =
    mkEnableOption "Enable OpenTabletDriver when osu-lazer is enabled";

  config = mkIf cfg.enable { hardware.opentabletdriver.enable = true; };
}
