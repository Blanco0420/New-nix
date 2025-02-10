{ options, config, pkgs, lib, ... }:
with lib;
with lib.custom;
let cfg = config.system.custom.desktop;
in {
  options.system.custom.desktop = with types; {
    enable = mkBoolOpt false "Enable desktop environment";
    environent = mkOpt {
      type = enum [ "plasma" "xfce" ];
      description = "Choose what desktop environment to use (plasma | xfce)";
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      services.xserver.enable = true;
      services.displayManager.defaultSession = cfg.environent;
    }

    (mkIf (cfg.environent == "plasma") {
      services = {
        displayManager.sddm = {
          enable = true;
          wayland.enable = true;
        };
        desktopManager.plasma6.enable = true;
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
    })
    (mkIf (cfg.desktop == "xfce") {
      nixpkgs.config.pulseaudio = true;
      services.xserver = {
        desktopManager = {
          xterm.enable = false;
          xfce.enable = true;
        };
      };
    })
  ]);
}
