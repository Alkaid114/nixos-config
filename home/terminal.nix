{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
  };
  xdg.configFile."kitty".source = ./dotfiles/.config/kitty;
}
