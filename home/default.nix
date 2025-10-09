{ ... }:
{
  imports = [
    ./fcitx5.nix
    ./shell
    ./terminal.nix
    ./niri
    ./stylix.nix
    ./coding
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "google-chrome";
    TERMINAL = "wezterm";
  };
}
