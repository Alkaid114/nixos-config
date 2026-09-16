{ ... }:
{
  imports = [
    ./desktop
    ./shell
    ./coding
    ./gaming
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "google-chrome-stable";
    TERMINAL = "kitty";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
  };

  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

}
