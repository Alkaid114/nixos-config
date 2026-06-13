{
  inputs,
  ...
}:
let
  myNixvimConfig = import ../../nixvim;
in
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = myNixvimConfig // { enable = true; };
}
