{
  plugins.gitsigns = {
    enable = true;

    lazyLoad.settings = {
      keys = [
        {
          __unkeyed-1 = "<leader>gs";
          desc = "Stage hunk";
        }
        {
          __unkeyed-1 = "<leader>gr";
          desc = "Reset hunk";
        }
        {
          __unkeyed-1 = "<leader>gb";
          desc = "Blame line";
        }
      ];
    };

    settings = {
      current_line_blame = true;
      current_line_blame_opts.delay = 500;
    };
  };
}
