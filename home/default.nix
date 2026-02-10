{ ... }:
{
  imports = [
    ./fcitx5.nix
    ./shell
    ./terminal.nix
    ./niri
    # ./stylix
    ./coding
    ./social.nix
    ./tools.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "google-chrome-stable";
    TERMINAL = "kitty";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
