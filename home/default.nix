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
    ./games.nix
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
}
