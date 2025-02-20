inputs@{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.system.custom.gpu.nvidia;
in {
  options.system.custom.gpu.nvidia = with types; {
    enable = mkBoolOpt false "Enable Nvidia GPU drivers";
  };
  config = mkIf cfg.enable {
    hardware.graphics = { enable = true; };
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    # Specialisation for "on-the-go" mode
    specialisation = {
      "on-the-go".configuration = {
        system.nixos.tags = [ "on-the-go" ];
        hardware.nvidia = {
          prime.offload.enable = lib.mkForce true;
          prime.offload.enableOffloadCmd = lib.mkForce true;
          prime.sync.enable = lib.mkForce false;
        };

      };
    };
  };
}
