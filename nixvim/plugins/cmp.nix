{
  plugins.cmp = {
    enable = true;

    lazyLoad.settings = {
      event = "InsertEnter";
    };

    settings = {
      snippet.expand = "luasnip";
      mapping = {
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.close()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = {
          __raw = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };
      };

      sources = [
        { name = "nvim_lsp"; }
        { name = "nvim_lua"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
    };
  };

  plugins.luasnip = {
    enable = true;
  };
}
