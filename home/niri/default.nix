{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./wallpaper.nix
    ./swaylock.nix
    ./waybar.nix
    # ./dms.nix
    ./noctalia.nix
    ./mako.nix
  ];
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.polkit-gnome.enable = true; # polkit
  services.swayidle.enable = true; # idle management daemon

  # 夜光护眼软件
  # services.wlsunset = {
  #   enable = true;
  #   sunset = "00:00";
  #   sunrise = "00:00";
  #   temperature.night = 5700;
  # };

  # 外接显示器时禁用笔记本屏幕
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "laptop-only";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "with-dp5";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-5";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "with-hdmi";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "HDMI-1";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "with-both";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-5";
              status = "enable";
            }
            {
              criteria = "HDMI-1";
              status = "enable";
            }
          ];
        };
      }
    ];
  };

  home.packages = with pkgs; [
    matugen
    cliphist
  ];
  programs.cava.enable = true;
  services.cliphist.enable = true;

  # programs.dankMaterialShell = {
  #   enable = true;
  #   enableSystemd = true;
  # };
  # xdg.configFile = {
  #   # "swaylock".source = ../dotfiles/swaylock;

  #   "niri".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/niri";
  #   # "waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/waybar";
  #   "fuzzel".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/fuzzel";
  # };
  xdg.configFile = {
    # "niri".source =
    #   config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/dotfiles/niri";

    "niri".source = ../dotfiles/niri;
    "fuzzel".source = ../dotfiles/fuzzel;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME="gtk3";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
}
