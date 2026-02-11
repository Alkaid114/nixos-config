{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
    };
  };
  programs.dconf.enable = true;
  security.polkit.enable = true;
  xdg.portal.enable = true;
  security.rtkit.enable = true;
  services = {
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      audio = {
        enable = true;
      };
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    flatpak.enable = true;
    libinput.enable = true;
  };
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  environment.systemPackages = with pkgs; [
    btrfs-progs
    mesa-demos
    pciutils
    usbutils
    alsa-utils
    # pavucontrol
  ];
}
