{ pkgs, namespace, ... }:
{

  roles = {
    common.enable = true;
    # desktop.enable = true;
    office.enable = true;
    # social.enable = true;
  };

  custom.user = {
    enable = true;
    name = "blanco";
  };

  home.stateVersion = "24.05";
}
