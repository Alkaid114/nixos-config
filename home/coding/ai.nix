{ pkgs, ... }:
{
  home.packages = with pkgs; [
    opencode
    cc-switch
  ];
}
