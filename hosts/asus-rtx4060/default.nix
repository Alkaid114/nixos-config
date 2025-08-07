# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../modules/system.nix
    
    ../../modules/hyprland.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.5";
    QT_SCALE_FACTOR = "1.5";
  };

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    systemd-boot.enable = true;
    # grub = {
    #   enable = true;
    #   device = "/dev/sda"; #  "nodev"
    #   efiSupport = false;
    #   useOSProber = true;
    #   #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
    # };
  };

  hardware.enableAllFirmware = true;
  networking.hostName = "asus-rtx4060"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # 使用 NVIDIA 和 AMD 驱动
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

  # NVIDIA 驱动配置
  hardware.nvidia = {
    modesetting.enable = true;     # 必须启用，Wayland 依赖
    open = false;                  # 使用闭源驱动
    nvidiaSettings = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = false;         # 禁用 PRIME sync
      offload.enable = false;      # 禁用 PRIME offload
    };
  };

  # AMDGPU 模块
  boot.kernelModules = [ "amdgpu" ];

  # 禁用开源nvidia驱动
  boot.kernelParams = [ "modprobe.blacklist=nouveau" ];	
  boot.blacklistedKernelModules = [ "nouveau" ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}