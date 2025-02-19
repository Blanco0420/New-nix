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
  cfg = config.system.custom.japaneseInput;
in
{
  options.system.custom.japaneseInput = with types; {
    enable = mkBoolOpt false "Whether or not to enable japanese input.";
  };

  config = mkIf cfg.enable {
    # i18n.inputMethod = {
    #   type = "ibus";
    #   enable = true;
    #   ibus.engines = with pkgs.ibus-engines; [ mozc-ut ];

    # };
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc-ut
        fcitx5-gtk
      ];
    };
    # environment.systemPackages = with pkgs; [
    # ];
  };
}
