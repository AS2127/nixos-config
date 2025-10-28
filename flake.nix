/*{
	description = "My NixOS Laptop";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#matshell = {
			#url = "github:Neurarian/matshell";
			#inputs.nixpkgs.follows = "nixpkgs";
		#};

		caelestia-shell = {
			url = "github:AS2127/shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		neovim = {
			url = "github:lotgenoot141/neovim-config";
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
	};

	outputs = inputs @ { nixpkgs, home-manager, neovim, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; lib = nixpkgs.lib; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit inputs; lib = nixpkgs.lib; };
					home-manager.users.aryan = import ./home.nix;
				}
			];
		};
	};
}*/

{
  description = "My NixOS Laptop";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "path:/home/aryan/.config/caelestia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:lotgenoot141/neovim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar = {
      url = "github:Alexays/Waybar/0.13.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    clipse-gui = {
      url = "path:./clipse-gui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib.extend (final: prev: {
      hm = home-manager.lib.hm;
    });
  in {
    # ✅ Added this block to properly expose caelestia-shell as a package
    packages.${system}.caelestia-shell = import ./caelestia-shell.nix {
      inherit (nixpkgs.legacyPackages.${system})
        stdenv lib makeWrapper makeFontsConf fish ddcutil brightnessctl app2unit
        networkmanager lm_sensors swappy wl-clipboard libqalculate bash hyprland
        material-symbols rubik nerd-fonts qt6 quickshell aubio libcava fftw
        pipewire xkeyboard-config cmake ninja pkg-config caelestia-cli
        papirus-icon-theme adwaita-icon-theme hicolor-icon-theme acpi;
      rev = "local";
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs lib; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs lib; };
          home-manager.users.aryan = import ./home.nix;
        }
      ];
    };
  };
}

