{ ... }:
{
  imports = [
    ./fcitx5.nix
    ./shell
    ./terminal.nix
    ./niri
    ./stylix
    ./coding
    ./social.nix
    ./commonTools.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "google-chrome";
    TERMINAL = "wezterm";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
