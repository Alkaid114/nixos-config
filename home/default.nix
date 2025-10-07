{...}: {
  imports = [
    ./fcitx5.nix
    ./shell
    ./packages.nix
    ./git.nix
    ./terminal.nix
    ./niri
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "google-chrome";
    TERMINAL = "wezterm";
  };
}