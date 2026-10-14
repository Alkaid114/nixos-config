{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    sideloadInitLua = true;
    plugins = with pkgs.vimPlugins; [
      bufferline-nvim
      neo-tree-nvim
      lualine-nvim
      nvim-web-devicons
      direnv-nvim
      guess-indent-nvim
      vim-nix
      catppuccin-nvim
      nvim-autopairs
      (nvim-treesitter.withPlugins (p: [
        p.lua
        p.python
        p.nix
        p.bash
        p.javascript
        p.typescript
        p.rust
        p.c
        p.cpp
        p.zig
      ]))
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      rainbow-delimiters-nvim
      indent-blankline-nvim
    ];
    extraPackages = with pkgs; [
      ripgrep
      fd
      wl-clipboard
      # lsp
      lua-language-server
      pyright
      nixd
      typescript-language-server
    ];
  };

  programs.neovide = {
    enable = true;
    settings = {
      font = {
        normal = [
          {
            family = "JetBrains Mono";
            size = 13;
          }
          {
            family = "Noto Sans Mono CJK SC";
            size = 13;
          }
          {
            family = "Noto Color Emoji";
            size = 13;
          }
          {
            family = "Nerd Font Mono";
            size = 13;
          }
        ];
      };
    };
  };
}
