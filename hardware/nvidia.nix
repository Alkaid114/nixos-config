{ ... }:
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
