{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./wallpaper.nix
  ];
  programs.fuzzel.enable = true;
  services.polkit-gnome.enable = true;

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
  ];
  programs.cava.enable = true;
  xdg.configFile = {
    "niri".source = ../dotfiles/.config/niri;
    "fuzzel".source = ../dotfiles/.config/fuzzel;
    "DankMaterialShell".source = ../dotfiles/.config/DankMaterialShell;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
}
