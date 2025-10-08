{pkgs,lib,...}:
{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  #system.modulesTree = [ (lib.getOutput "modules" pkgs.linuxPackages_cachyos.kernel) ];
}
