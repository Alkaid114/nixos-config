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
        meow
        nerd-icons
        catppuccin-theme
        avy
        consult
        consult-flycheck
        orderless
        general
        copilot
        treesit-auto
        apheleia
        vertico
	      company-math
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
