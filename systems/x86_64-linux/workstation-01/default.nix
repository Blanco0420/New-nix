{ ... }:
{
  imports = [
    ./disko.nix
    #./hardware-configuration.nix
    ./secrets/secrets.nix
  ];

  networking.hostName = "workstation-01";
  
    roles = {
      common.enable = true;
    };

    system.stateVersion = "25.05";
  }
