{
  description = "My NixOS Laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    clipse-gui = {
      url = "path:./clipse-gui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, clipse-gui, ... }:
  let
    system = "x86_64-linux";

    # Overlay for clipse-gui must be defined inside outputs
    clipseOverlay = final: prev: {
      clipse-gui = clipse-gui.packages.${system}.default;
    };
  in
  {
    nixosConfigurations = {

      # LAPTOP CONFIG
      nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/laptop/configuration.nix
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ clipseOverlay ];
          })
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.aryan = import ./home;
          }
        ];
      };

      # DESKTOP CONFIG
      nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ clipseOverlay ];
          })
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.aryan = import ./home;
          }
        ];
      };
    };
  };
}



/*{
  description = "My NixOS Laptop";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
    	url = "github:nix-community/neovim-nightly-overlay";
	inputs.nixpkgs.follows = "nixpkgs";
    };

	clipse-gui = {
			url = "path:./clipse-gui";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	
  };

    
  outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
	clipseOverlay = final: prev: {
	  clipse-gui = inputs.clipse-gui.packages.${prev.system}.default;
  };
    nixosConfigurations = {
      # LAPTOP CONFIG - UNTOUCHED!
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.aryan = import ./home;
          }
        ];
      };
      
      # DESKTOP CONFIG - MINIMAL NOW
      nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
		overlays = [ self.overlays.default ];
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.aryan = import ./home;
          }
        ];
      };
    };
  };
}*/

