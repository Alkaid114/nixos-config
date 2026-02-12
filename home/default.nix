{ ... }:
{
  imports = [
    ./fcitx5.nix
    ./shell
    ./kitty.nix
    ./niri
    # ./stylix
    ./coding
    ./social.nix
    ./tools.nix
    ./games.nix
    ./kanshi.nix
    ./fuzzel.nix
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
