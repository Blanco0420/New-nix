{ lib, pkgs, config, namespace, ... }:
let cfg = config.styles.stylix;
in {
  options.styles.stylix = { enable = lib.mkEnableOption "Enable stylix"; };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      homeManagerIntegration.autoImport = false;
      homeManagerIntegration.followSystem = false;

      image = pkgs.custom.wallpapers.main;

      cursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
      };

      fonts = {
        sizes = {
          terminal = 14;
          applications = 10;
          popups = 10;
        };

        serif = {
          name = "Source Serif CJK JP";
          package = pkgs.source-serif;
        };

        sansSerif = {
          name = "Noto Sans CJK JP";
          package = pkgs.noto-fonts-cjk-sans;
        };
        monospace = {
          name = "Noto Sans Mono CJK JP";
          package = pkgs.noto-fonts-cjk-sans;
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
        # monospace = {
        #   package = pkgs.b612;
        #   name = "b612 Font";
        # };

        # emoji = {
        #   package = pkgs.noto-fonts-emoji;
        #   name = "Noto Color Emoji";
        # };
      };
    };
  };
}
