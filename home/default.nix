{ ... }:
{
  imports = [
    ./fcitx5.nix
    ./shell
    ./kitty.nix
    ./niri
    ../common/stylix
    ./coding
    ./social.nix
    ./tools.nix
    ./games.nix
    ./kanshi.nix
    ./fuzzel.nix
    #./theme.nix
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
