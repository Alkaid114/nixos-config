# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  username,
  STATE_VERSION,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    # systemd-boot.enable = true;
    grub = {
      enable = true;
      device = "nodev"; # "nodev"
      efiSupport = true;
      useOSProber = true; # 自动检测 Windows
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
    };
  };

  #hardware.enableAllFirmware = true;
  networking.hostName = "asus-rtx4060"; # Define your hostname.
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.

  # 使用 NVIDIA 和 AMD 驱动
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];

  # NVIDIA 驱动配置
  hardware.nvidia = {
    modesetting.enable = true; # 必须启用，Wayland 依赖
    open = false; # 使用闭源驱动
    nvidiaSettings = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = false; # 禁用 PRIME sync
      offload.enable = false; # 禁用 PRIME offload
    };
  };

  # AMDGPU 模块
  boot.kernelModules = [ "amdgpu" ];

  # 禁用开源nvidia驱动
  boot.kernelParams = [ "modprobe.blacklist=nouveau" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  services.supergfxd.enable = true;

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };

    # 如果设备需要很长时间才能取消挂起（键盘，鼠标等），则禁用
    power-profiles-daemon.enable = false;
    # tlp = {
    #   enable = true;
    #   settings = {
    #     CPU_BOOST_ON_AC = 1;
    #     CPU_BOOST_ON_BAT = 0;
    #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    #     STOP_CHARGE_THRESH_BAT0 = 85;
    #   };
    # };
  };

  # systemd.services.sign-nvidia-module = {
  #   description = "Sign NVIDIA kernel module with MOK key";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "generate-mok-key.service" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = ''
  #       key="/etc/secureboot/MOK.key"
  #       cert="/etc/secureboot/MOK.crt"
  #       modpath=$(modinfo -n nvidia)

  #       if [ -f "$modpath" ]; then
  #         /lib/modules/$(uname -r)/build/scripts/sign-file sha256 "$key" "$cert" "$modpath"
  #       fi
  #     '';
  #   };
  # };

  # system.activationScripts.signEfiAndModules = {
  #   text = ''
  #     PATH=${pkgs.lib.makeBinPath [ pkgs.sbsigntool pkgs.kmod pkgs.openssl ]}
  #     key="/etc/secureboot/MOK.key"
  #     cert="/etc/secureboot/MOK.crt"

  #     # 签名 NVIDIA 驱动模块
  #     nvidia_mod=$(modinfo -n nvidia || true)
  #     if [ -f "$nvidia_mod" ]; then
  #       sign_file="/lib/modules/$(uname -r)/build/scripts/sign-file"
  #       if [ -x "$sign_file" ]; then
  #         "$sign_file" sha256 "$key" "$cert" "$nvidia_mod"
  #       fi
  #     fi
  #   '';
  # };

  # systemd.services.supergfxd.path = [ pkgs.pciutils ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = STATE_VERSION; # Did you read the comment?
}
