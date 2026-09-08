{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages =
      epkgs: with epkgs; [
        use-package
        undo-tree
        which-key
        magit
        markdown-mode
        dashboard
        doom-modeline
      ];
  };
}
