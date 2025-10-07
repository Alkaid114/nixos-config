{pkgs}:
{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  system.modulesTree = [ (lib.getOutput "modules" kernel) ];
}