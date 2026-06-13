{
  plugins.lsp = {
    enable = true;

    servers = {
      nixd.enable = true;
      pyright.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      ts_ls.enable = true;
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            runtime.version = "LuaJIT";
            diagnostics.globals = [ "vim" ];
            workspace.checkThirdParty = false;
          };
        };
      };
    };

    keymaps = {
      silent = true;
      lspBuf = {
        gd = "vim.lsp.buf.definition";
        gD = "vim.lsp.buf.declaration";
        K = "vim.lsp.buf.hover";
        gi = "vim.lsp.buf.implementation";
        gr = "vim.lsp.buf.references";
      };
      diagnostic = {
        "[d" = "vim.diagnostic.goto_prev";
        "]d" = "vim.diagnostic.goto_next";
      };
    };
  };

  plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      formatters_by_ft = {
        nix = [ "nixfmt" ];
        python = [
          "isort"
          "black"
        ];
        rust = [ "rustfmt" ];
        lua = [ "stylua" ];
        javascript = [
          "prettierd"
          "prettier"
        ];
        typescript = [
          "prettierd"
          "prettier"
        ];
        javascriptreact = [
          "prettierd"
          "prettier"
        ];
        typescriptreact = [
          "prettierd"
          "prettier"
        ];
        json = [
          "prettierd"
          "prettier"
        ];
        yaml = [
          "prettierd"
          "prettier"
        ];
        markdown = [
          "prettierd"
          "prettier"
        ];
        html = [
          "prettierd"
          "prettier"
        ];
        css = [
          "prettierd"
          "prettier"
        ];
      };
    };
  };

  plugins.lspkind = {
    enable = true;

    settings = {
      cmp = {
        enable = true;
        menu = {
          nvim_lsp = "[LSP]";
          nvim_lua = "[Lua]";
          luasnip = "[Snip]";
          buffer = "[Buf]";
          path = "[Path]";
        };
      };
    };
  };
}
