{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./git.nix
    ./vscode.nix
    ./nixvim.nix
  ];

  home.packages = with pkgs; [
    uv
    filezilla
    bun
    python3
  ];

  home.sessionVariables.PATH = "${pkgs.bun}/bin:${config.home.homeDirectory}/.bun/bin:$PATH";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
