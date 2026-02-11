{ config, pkgs, ... }:

{
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
          fcitx5-chinese-addons
          fcitx5-with-addons
          fcitx5-qt
          fcitx5-configtool
        ]);
      settings = {
        addons = {
        };
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "rime";
          GroupOrder."0" = "Default";
        };
      };

    };
  };

  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
  };
}
