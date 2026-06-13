{
  extraConfigLua = ''
    vim.opt.list = true
    vim.opt.listchars = { trail = "·", nbsp = "·" }
    vim.opt.undodir = vim.fn.expand("~/.local/state/nvim/undodir")
  '';
}
