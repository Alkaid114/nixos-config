{ config, pkgs, ... }:
let
  rime-ice-src = pkgs.fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "5bc4d3057a1953c3d273fb3408ac4e13f2f593b6";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; 
  };
in
{
  xdg.configFile."fcitx5/rime" = {
    source = rime-ice-src;
    recursive = true;
  };

  xdg.configFile."fcitx5/rime/default.custom.yaml".text = ''
    patch:
      schema_list:
        - schema: double_pinyin
      
      menu/page_size: 7
  '';

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons =
        with pkgs;
        [
          fcitx5-mozc
          fcitx5-gtk
          qt6Packages.fcitx5-chinese-addons
          fcitx5-nord
          fcitx5-rime
          fcitx5-table-extra
        ]
        ++ (with kdePackages; [
          fcitx5-qt
          fcitx5-configtool
        ]);
      settings = {
        globalOptions = {
          "Appearance" = {
            "DarkTheme" = "Nord-Dark";
            "Theme" = "Nord-Dark";
          };
        };
        addons = {
          "classicui/globalSection" = {
            "Font" = "Noto Sans CJK SC 11";
            "MenuFont" = "Noto Sans CJK SC 11";
          };
        };
        inputMethod = {
          "Groups/0" = {
            "Name" = "Default";
            "Default Layout" = "us";
            "DefaultIM" = "rime";
          };
          "Groups/0/Items/0".Name = "rime";
          GroupOrder."0" = "Default";
        };
      };

    };
  };

  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
}
