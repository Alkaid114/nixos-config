{
  pkgs,
  ...
}:
{
  imports = [
    ./git.nix
    ./editor.nix
    ./ai.nix
  ];

  home.packages = with pkgs; [
    uv
    nodejs_24
    filezilla
  ];

  # home.sessionVariables.PATH = "${pkgs.bun}/bin:${config.home.homeDirectory}/.bun/bin:$PATH";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
