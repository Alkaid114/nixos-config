{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      font = "JetBrainsMono Nerd Font 12";
      drun-display-format = "{name}";
    };
    theme = builtins.readFile ./themes/rofi.rasi;
  };
}
