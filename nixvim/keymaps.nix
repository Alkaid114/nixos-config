{
  keymaps = [
    # Better escape
    {
      mode = "i";
      key = "jk";
      action = "<Esc>";
    }
    {
      mode = "i";
      key = "kj";
      action = "<Esc>";
    }

    # Window navigation
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w><C-h>";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w><C-j>";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w><C-k>";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w><C-l>";
    }

    # Better indenting
    {
      mode = "v";
      key = "<";
      action = "<gv";
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
    }

    # Move lines
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
    }

    # Clear search highlights
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }

    # Telescope
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options.desc = "Find buffers";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<CR>";
      options.desc = "Help tags";
    }

    # Git
    {
      mode = "n";
      key = "<leader>gs";
      action = "<cmd>Gitsigns stage_hunk<CR>";
      options.desc = "Stage hunk";
    }
    {
      mode = "n";
      key = "<leader>gr";
      action = "<cmd>Gitsigns reset_hunk<CR>";
      options.desc = "Reset hunk";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Gitsigns blame_line<CR>";
      options.desc = "Blame line";
    }

    # Comment
    {
      mode = "n";
      key = "<leader>/";
      action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
      options.desc = "Toggle comment";
    }
    {
      mode = "v";
      key = "<leader>/";
      action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
      options.desc = "Toggle comment (visual)";
    }
  ];
}
