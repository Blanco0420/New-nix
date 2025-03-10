{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.roles.laptop;
in
{
  options.roles.laptop = with types; {
    enable = mkBoolOpt false "gaming nixos configuration.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    system.custom = {
      battery.enable = true;
    };
    services.logind.lidSwitchExternalPower = "ignore";
    # Stupid java vscode extension fix
    programs.nix-ld.enable = true;
  };
}
