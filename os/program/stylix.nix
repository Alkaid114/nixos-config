{ pkgs, ... }:
let
  theme = "catppuccin-mocha";
in
{
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  stylix.targets.fontconfig.enable = false;
  stylix.cursor = {
    size = 18;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
  };
  stylix.icons = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
    light = "Papirus-Light";
  };
}
