{ pkgs, ... }:
{
  imports = [
    ./desktop
    ./shell
    ./coding
    ./gaming
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "google-chrome-stable";
    TERMINAL = "kitty";
  };

  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.packages = with pkgs; [
    gnome-themes-extra
  ];
}
