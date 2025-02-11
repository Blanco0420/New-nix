{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.roles.remote;
in {
  options.roles.remote = with types; {
    enable = mkBoolOpt false "enable remote software role";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ xpipe rustdesk ]; };
}
