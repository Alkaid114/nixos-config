{
  imports = [
    ./options.nix
    ./globals.nix
    ./keymaps.nix
    ./colorscheme.nix
    ./extra.nix
    ./plugins
  ];

  plugins.lz-n.enable = true;
}
