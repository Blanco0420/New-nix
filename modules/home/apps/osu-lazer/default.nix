{ inputs, lib, host, pkgs, config, namespace, ... }:
with lib;
let cfg = config.apps.osu-lazer;
in {
  options.apps.osu-lazer = { enable = mkEnableOption "enable osu-lazer"; };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin # installs a package
    ];
    home.file = {
      ".config/OpenTabletDriver/Presets/osu.json".source =
        ./configs/openTabletDriver/osu.json;
    };
  };
}

