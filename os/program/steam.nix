{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extest.enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };
}