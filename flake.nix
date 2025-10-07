{
  description = "Alkaid's NixOS flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-25.05/nixexprs.tar.xz";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake"; 
    stylix.url = "github:nix-community/stylix/release-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager,chaotic,niri ,stylix, ... }@inputs: 
    let
      mkHost = 
        {hostname,username}:
        let
          STATE_VERSION = 25.05;
        in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inputs = inputs;
              hostname = hostname;
              username = username;
              STATE_VERSION = STATE_VERSION;
            };
            modules = [
              ./hosts/${hostname}
              ./system
              ./common/system.nix

              niri.nixosModules.niri  
              stylix.nixosModules.stylix

              {  
                nixpkgs.overlays = [ niri.overlays.niri ];
              }  

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.users.${username} = {
                  home = {
                    inherit username;
                    homeDirectory = "/home/${username}";
                    stateVersion = STATE_VERSION;
                  };

                  imports = [ ./home ];
                };
                home-manager.extraSpecialArgs = {
                  # inherit (inputs) plasma-manager;
                  inherit username;
                  inherit hostname;
                };
              }

              chaotic.nixosModules.nyx-cache
              chaotic.nixosModules.nyx-overlay
              chaotic.nixosModules.nyx-registry
            ];
          };
    in
    {
      nixosConfigurations = {
        alkaid-qemu = mkHost {hostname="alkaid-qemu";username="alkaid";};
        asus-rtx4060 = mkHost {hostname="asus-rtx4060";username="alkaid";};
      };
    };
}