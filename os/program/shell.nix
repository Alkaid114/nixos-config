{ pkgs, ... }:
{
  environment.shells = with pkgs; [
    bash
    zsh
  ];
  programs.bash.enable = true;
  programs.zsh.enable = true;
}
