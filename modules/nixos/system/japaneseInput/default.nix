{ options, config, pkgs, lib, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.system.custom.japaneseInput;
in {
  options.system.custom.japaneseInput = with types; {
    enable = mkBoolOpt false "Whether or not to enable japanese input.";
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
      fonts.packages = with pkgs; [ noto-fonts-cjk noto-fonts-emoji ];
    };
  };
  environment.systemPackages = with pkgs; [
    fcitx5
    fcitx5-mozc
    fcitx5-gtk # GTK support
    fcitx5-qt # Qt support (for KDE Plasma)
    fcitx5-configtool # GUI config tool
  ];
}
