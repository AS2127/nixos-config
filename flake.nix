{
	description = "My NixOS Laptop";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		neovim = {
			url = "github:lotgenoot141/neovim-config";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ { nixpkgs, home-manager, neovim, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit inputs; };
					home-manager.users.aryan = import ./home.nix;
				}
			];
		};
	};
}
