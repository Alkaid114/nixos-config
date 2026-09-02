{
  pkgs,
  ...
}:
{
  imports = [
    ./git.nix
    ./vscode.nix
    ./ai.nix
  ];

  home.packages = with pkgs; [
    uv
    filezilla
  ];

  # home.sessionVariables.PATH = "${pkgs.bun}/bin:${config.home.homeDirectory}/.bun/bin:$PATH";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
