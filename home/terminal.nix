{ config, pkgs, ... }:
{
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
    return {
      default_prog = { "${pkgs.fish}/bin/fish" }
    }
  '';
}
