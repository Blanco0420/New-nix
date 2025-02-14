{ options, config, pkgs, lib, ... }:
with lib;
with lib.custom;
let cfg = config.system.custom.desktop;
in {
  options.system.custom.desktop = with types; {
    enable = mkBoolOpt false "Enable desktop environment";
    kde = mkBoolOpt false "Enable KDE Plasma";
    xfce = mkBoolOpt false "Enable xfce";
  };
  config = mkIf cfg.enable (mkMerge [
    { services.xserver.enable = true; }

    (mkIf cfg.kde {
      services = {
        displayManager.sddm = {
          enable = true;
          wayland.enable = true;
        };
        desktopManager.plasma6.enable = true;
        displayManager.defaultSession = "plasma";
      };

      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        gwenview
        # konsole
        oxygen
        kate
        elisa
        khelpcenter
        kwallet
        kwalletmanager
      ];
      environment.systemPackages = with pkgs; [ kdePackages.filelight ];
      programs.dconf.enable = true;
    })

    (mkIf cfg.xfce {
      nixpkgs.config.pulseaudio = true;
      services = {
        xserver = {
          desktopManager = {
            xterm.enable = false;
            xfce.enable = true;
          };
        };
        displayManager.defaultSession = "xfce";
      };
    })
  ]);
}
