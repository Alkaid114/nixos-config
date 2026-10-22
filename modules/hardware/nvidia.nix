{ config, lib, ... }:
let
  cfg = config.my.hardware.nvidia;
  prime = cfg.prime;
in
{
  options.my.hardware.nvidia = {
    enable = lib.mkEnableOption "NVIDIA 驱动与容器工具链";
    prime = {
      enable = lib.mkEnableOption "PRIME 混合输出与 offload";
      nvidiaBusId = lib.mkOption {
        type = lib.types.str;
        description = "NVIDIA GPU 的 PCI Bus ID，例如 PCI:1:0:0";
      };
      amdgpuBusId = lib.mkOption {
        type = lib.types.str;
        description = "AMD 核显的 PCI Bus ID，例如 PCI:6:0:0";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [
      "nvidia"
    ];

    hardware = {
      nvidia =
        lib.recursiveUpdate
          {
            modesetting.enable = true;
            open = true;
            nvidiaSettings = true;
            powerManagement.enable = true;
            videoAcceleration = true;
            dynamicBoost.enable = true;
          }
          (
            lib.optionalAttrs prime.enable {
              prime = {
                offload = {
                  enable = true;
                  enableOffloadCmd = true;
                  offloadCmdMainProgram = "prime-run";
                };
                inherit (prime) nvidiaBusId amdgpuBusId;
              };
              powerManagement.finegrained = true;
            }
          );
      nvidia-container-toolkit.enable = true;
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    boot.kernelParams = [ "modprobe.blacklist=nouveau" ];
    boot.blacklistedKernelModules = [ "nouveau" ];
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
}
