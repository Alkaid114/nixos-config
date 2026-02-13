{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableInteractive = true;
    settings = lib.importTOML ../dotfiles/.config/starship.toml;
  };
}
