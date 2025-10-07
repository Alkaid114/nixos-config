{pkgs, ...}:
{
  imports = [
    ./dm.nix
  ];

  programs.niri.enable = true;

  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};

  # programs.alacritty.enable = true; # Super+T in the default setting (terminal)
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  programs.waybar.enable = true; # launch on startup in the default setting (bar)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon

  environment.systemPackages = with pkgs; [ 
    wezterm 
    fuzzel 
    swaylock 
    mako 
    swayidle
    xwayland-satellite
    gnome-keyring
    wlsunset
  ];

  # 夜光护眼软件
  services.wlsunset = {
    enable = true;
    sunset = "00:00";
    sunrise = "00:00";
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  # polkit agent
  security.soteria.enable = true;

  # 压缩解压
  programs.file-roller.enable = true;
}