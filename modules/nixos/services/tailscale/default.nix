{ lib, pkgs, config, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.services.custom.tailscale;
in {
  options.services.custom.tailscale = with types; {
    enable = mkBoolOpt false "Whether or not to configure Tailscale";
    autoconnect = {
      enable = mkBoolOpt false
        "Whether or not to enable automatic connection to Tailscale";
      key = mkOpt str "" "The authentication key to use";
    };
  };

  config = mkIf cfg.enable {
    # assertions = [{
    #   assertion = cfg.autoconnect.enable -> cfg.autoconnect.key != "";
    #   message = "services.tailscale.autoconnect.key must be set";
    # }];

    environment.systemPackages = with pkgs; [ tailscale ];
    services.tailscale.useRoutingFeatures = "client";

    services.tailscale.enable = true;

    networking = {
      firewall = {
        trustedInterfaces = [ "tailscale0" ];

        allowedUDPPorts = [ config.services.tailscale.port ];

        # Strict reverse path filtering breaks Tailscale exit node use and some subnet routing setups.
        checkReversePath = "loose";
      };

      networkmanager.unmanaged = [ "tailscale0" ];
    };
  };
}
