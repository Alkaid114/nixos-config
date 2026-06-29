{ pkgs, ... }:
{
  services.xserver.videoDrivers = [
    "amdgpu"
  ];

  hardware = {
    amdgpu = {
      initrd = {
        enable = true;
      };
      opencl.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };

  boot.kernelModules = [
    "amdgpu"
  ];

  environment.systemPackages = with pkgs; [
    libva-utils
    vdpauinfo
  ];
}
