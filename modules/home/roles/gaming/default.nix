{ options, inputs, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.roles.gaming;
in {
  options.roles.gaming = with types; {
    enable = mkBoolOpt false "enable gaming role";
  };

  config = mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = { cpu_load_change = true; };
    };
    apps.osu-lazer.enable = true;
    home.packages = with pkgs; [
      inputs.nix-gaming.packages.${pkgs.system}.wine-ge
      lutris
      # winetricks
      # wineWowPackages.stable
      headsetcontrol
    ];
  };
}
