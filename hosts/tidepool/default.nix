{ config, pkgs, self, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    # load modules on boot
    kernelModules = [ "amdgpu" ];
    # use the latest kernel
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      "amd_pstate=active"
      "amd_iommu=on"
      "nvme_core.default_ps_max_latency=us=0"
    ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
    '';

  environment.systemPackages = [ config.boot.kernelPackages.cpupower ];

  networking.hostname = "tidepool";

  programs = {
    # enable hyprland
    hyprland.enable = true;
  };

  services = {
    fstrim.enable = true;
  };
}
