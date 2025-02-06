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
  cfg = config.services.custom.ssh;
in
{
  options.services.custom.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
  };

  config = mkIf cfg.enable {  
    networking.firewall = {
      allowedTCPPorts = [ 22 ];
    }; 
    services.openssh = {
      enable = true;
      ports = [22];

      settings = {
        PasswordAuthentication = false;
        StreamLocalBindUnlink = "yes";
        GatewayPorts = "clientspecified";
      };
    };
    users.users = {
      ${config.user.name}.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOC0ZVHQd0YmATfslSTtmXB7jcOGKmYdOBrwaY5TY1Nm blanco@blancorog"
      ];
    };
  };
}