{ pkgs, ... }:
let
  theme = "catppuccin-mocha";
in
{
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.targets.gtk.colors.enable = true;
  stylix.targets.gtk.flatpakSupport.enable = true;
  stylix.targets.qt.enable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  stylix.targets.fontconfig.fonts.enable = false;
  stylix.cursor = {
    size = 18;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
  };
  # stylix.fonts = {
  #   serif = {
  #     package = pkgs.noto-fonts-cjk-sans;
  #     name = "Noto Sans CJK SC";
  #   };

  #   sansSerif = {
  #     package = pkgs.noto-fonts-cjk-sans;
  #     name = "Noto Sans CJK SC";
  #   };

  #   monospace = {
  #     package = pkgs.nerd-fonts.jetbrains-mono;
  #     name = "JetBrains Mono Nerd Font";
  #   };

  #   emoji = {
  #     package = pkgs.noto-fonts-emoji;
  #     name = "Noto Color Emoji";
  #   };
  # };
}
