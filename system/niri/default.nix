{pkgs, ...}:
{
  imports = [
    ./dm.nix
  ];

  programs.niri.enable = true;


  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};

  # programs.alacritty.enable = true; # Super+T in the default setting (terminal)

  
  #programs.waybar.enable = true; # launch on startup in the default setting (bar)

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
