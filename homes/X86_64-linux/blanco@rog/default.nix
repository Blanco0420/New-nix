{ pkgs, namespace, ... }: {

  roles = {
    common.enable = true;
    desktop.enable = true;
    office.enable = true;
    gaming.enable = true;
    social.enable = true;
    dev.enable = true;
    media.enable = true;
    remote.enable = true;
  };

  services.custom = { syncthing.enable = false; };

  custom.user = {
    enable = true;
    name = "blanco";
  };

  home.stateVersion = "24.05";
}
