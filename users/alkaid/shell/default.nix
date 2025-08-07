{config, ...}:
{
  imports = [
    ./zsh.nix
    ./bash.nix
  ];

  # add environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "google-chrome";
    TERMINAL = "konsole";
  };

}