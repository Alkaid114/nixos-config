{ pkgs, ... }:
let
  theme = "catppuccin-mocha";
in
{
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.targets.console.enable = false;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  stylix.targets.fontconfig.enable = false;
  stylix.targets.plymouth.colors.enable = false;
  stylix.targets.plymouth.logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-colours.png";
}
