{
	description = "My NixOS Laptop";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		caelestia-shell = {
			url = "github:caelestia-dots/shell";
			# url = "github:AS2127/shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		waybar = {
			url = "github:Alexays/Waybar/0.13.0";
			# inputs.nixpkgs.follows = "nixpkgs";
		};

		clipse-gui = {
			url = "path:./clipse-gui";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		neovim-nightly-overlay = {
			url = "github:nix-community/neovim-nightly-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ { nixpkgs, home-manager, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit inputs; };
					home-manager.users.aryan = import ./home;
				}
			];
		};
	};
}

/*
outputs = inputs @ { nixpkgs, home-manager, ... }: let
	system = "x86_64-linux";
	lib = nixpkgs.lib.extend (final: prev: { hm = home-manager.lib.hm; });
in {
	packages.${system}.caelestia-shell = import ./caelestia-shell.nix {
		inherit (nixpkgs.legacyPackages.${system})
			stdenv lib makeWrapper makeFontsConf fish ddcutil brightnessctl app2unit
			networkmanager lm_sensors swappy wl-clipboard libqalculate bash hyprland
			material-symbols rubik nerd-fonts qt6 quickshell aubio libcava fftw
			pipewire xkeyboard-config cmake ninja pkg-config caelestia-cli
			papirus-icon-theme adwaita-icon-theme hicolor-icon-theme acpi;
		rev = "local";
	};
};
*/

