{ pkgs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8"; # 错误提示、命令行输出用英文
    LC_TIME = "zh_CN.UTF-8"; # 时间格式用中文
    LC_NUMERIC = "zh_CN.UTF-8"; # 数字格式用中文
    LC_MONETARY = "zh_CN.UTF-8"; # 货币格式用中文
    LC_PAPER = "zh_CN.UTF-8"; # 纸张尺寸用中文
    LC_NAME = "zh_CN.UTF-8";
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.dconf.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.polkit.enable = true;

  services = {

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    flatpak.enable = true;
  };

  xdg.portal.enable = true;

  environment.systemPackages = with pkgs; [
    btrfs-progs # Btrfs 命令行工具，如 btrfs subvolume/snapshot
    # snapper # 快照管理工具
    # btrfs-assistant # 图形化快照管理工具（如可用）
    mesa-demos
    # system tools
    sysstat
    ethtool
    pciutils # lspci
    usbutils # lsusb
    # audio
    alsa-utils
    pavucontrol
    libinput
    # bluetooth
    blueman
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    # 配置输入设备（键盘、鼠标）防止自动断开
    input = {
      General = {
        IdleTimeout = 0;  # 禁用空闲超时，防止键盘自动断开
        ClassicBondedOnly = false;
      };
    };
    # 全局蓝牙设置
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
}
