{
  plugins.which-key = {
    enable = true;

    settings = {
      delay = 300;
      icons.separator = "";

      spec = [
        {
          __unkeyed = "<leader>f";
          group = "Telescope";
        }
        {
          __unkeyed = "<leader>g";
          group = "Git";
        }
        {
          __unkeyed = "<leader>c";
          group = "Code/LSP";
        }
        {
          __unkeyed = "<leader>w";
          group = "Windows";
        }
      ];
    };
  };
}
