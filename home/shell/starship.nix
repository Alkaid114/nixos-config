{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableInteractive = true;
    settings = lib.importTOML ./starship.toml;
  };
}
