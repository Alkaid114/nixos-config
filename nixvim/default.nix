{
  imports = [
    ./options.nix
    ./globals.nix
    ./keymaps.nix
    ./colorscheme.nix
    ./extra.nix
    ./plugins
  ];

  lazy.enable = true;
}
