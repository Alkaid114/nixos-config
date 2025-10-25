{pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraLuaConfig = ''
      require('myinit')
    '';
  };
}