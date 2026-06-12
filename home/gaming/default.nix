{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    protonplus
    lutris
  ];
}
