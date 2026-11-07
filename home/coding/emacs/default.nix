{ pkgs, config, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages =
      epkgs:
      with epkgs;
      [
        # 插件
        use-package
        undo-tree
        which-key
        magit
        markdown-mode
        dashboard
        doom-modeline
        nerd-icons
        evil
        evil-collection
        catppuccin-theme
        avy
        evil-avy
        consult
        consult-flycheck
        orderless
        general
        copilot
        treesit-auto
        apheleia
        vertico
      ]
      ++ (with pkgs; [
        # 其他工具
        ripgrep

        # lsp
        ty
        nixd

        # formatter
        ruff
        nixfmt-tree
      ]);
  };

  home.file.".emacs.d/init.el".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/coding/emacs/init.el";
}
