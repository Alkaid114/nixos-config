{...}: 
{
  imports = [
    ./fcitx5.nix
    ./shell
    ./packages.nix
    ./git.nix
    ./terminal.nix
    ./niri
    ./stylix.nix
    ./mako.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "google-chrome";
    TERMINAL = "wezterm";
  };
}