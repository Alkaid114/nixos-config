{ pkgs, lib, ... }:
{
  gtk = {
    enable = true;
    theme = lib.mkForce {
      name = "catppuccin-mocha-blue-standard";

      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "blue" ];
        size = "standard";
      };
    };
    iconTheme = lib.mkDefault {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Noto Sans CJK SC";
      size = 12;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "catppuccin-mocha-blue-standard";
  };
}
