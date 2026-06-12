{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [
    "nvidia"
  ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      videoAcceleration = true;
      dynamicBoost.enable = true;
      # package =
      #   let
      #     base = config.boot.kernelPackages.nvidiaPackages.latest;
      #     cachyos-nvidia-patch = pkgs.fetchpatch {
      #       url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
      #       sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
      #     };

      #     driverAttr = if config.hardware.nvidia.open then "open" else "bin";
      #   in
      #   base
      #   // {
      #     ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
      #       patches = (oldAttrs.patches or [ ]) ++ [ cachyos-nvidia-patch ];
      #     });
      #   };
    };
    nvidia-container-toolkit.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # nix.settings = {
  #   substituters = [
  #     "https://cache.nixos-cuda.org"
  #   ];
  #   trusted-public-keys = [
  #     "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
  #   ];
  # };
  # nixpkgs.config.cudaSupport = true;

  boot.kernelParams = [ "modprobe.blacklist=nouveau" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
}
