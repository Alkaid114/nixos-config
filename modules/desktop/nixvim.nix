{
  inputs,
  ...
}:
let
  myNixvimConfig = import ../../nixvim;
in
{
  imports = [ inputs.nixvim.nixosModules.nixvim ];
  programs.nixvim = myNixvimConfig // { enable = true; };
}
