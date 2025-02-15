{ pkgs, namespace, ... }: {

  roles = {
    common.enable = true;
    # desktop.enable = true;
    office.enable = true;
    # social.enable = true;
  };

  services.custom = { syncthing.enable = false; };

  custom.user = {
    enable = true;
    name = "blanco";
  };

  home.stateVersion = "24.05";
}
