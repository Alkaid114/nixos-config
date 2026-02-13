{ pkgs, ... }:
{
  imports = [
    ./fcitx5.nix
    ./shell
    ./kitty.nix
    ./niri
    ./stylix.nix
    ./coding
    ./social.nix
    ./tools.nix
    ./gaming.nix
    ./kanshi.nix
    ./fuzzel.nix
    ./theme.nix
    ./dms-shell.nix
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

  home.packages =
    with pkgs;
    [
      gnome-themes-extra
    ];
}
