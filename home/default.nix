{ pkgs, inputs, lib, ... }: {
	imports = [
		# inputs.matshell.homeManagerModules.default
		./neovim
		./hyprland
		./waybar
		./fish
	];

	home = {
		username = "aryan";
		homeDirectory = "/home/aryan";
	};

	neovim = {
		enable = true;
	};

	xdg.enable = true;

	gtk = {
		enable = true;
		iconTheme = {
			name = "Papirus";
			package = pkgs.papirus-icon-theme;
		};

		cursorTheme = {
			name = "Oxygen-17-Black";
			size = 24;
		};
	};
	
	qt = {
		enable = true;
		platformTheme.name = "gtk";
		#platformTheme.name = "qtct";
	};

	# packages installed at the user level (https://search.nixos.org/packages)
	# *bluez-utils
	home.packages = with pkgs; [
		blueman
		bluez
		bluez-tools
		fzf
		btop
		vesktop
		fastfetch
		google-chrome
		brightnessctl
		wasistlos
		# inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar
		vscode
		tree
		bluez
		grim
		slurp
		swappy
		networkmanager_dmenu
		hyprpaper
		inputs.clipse-gui.packages.${pkgs.system}.default
		inputs.caelestia-shell.packages.${pkgs.system}.default
		adwaita-icon-theme
		papirus-icon-theme
		hicolor-icon-theme
		acpi
		tlp
		bitwarden-desktop
		seahorse
		libsecret
		tor-browser
		flatpak
		foot
		starship
		matugen
		pavucontrol
		wofi

	];


	programs.ghostty.enable = true;

	#programs.firefox.enable = true;


	##programs.matshell = {
		# Enable the basic shell
	##	enable = true; 
		# Enable a systemd service for matshell
	##	autostart = true;
		# Compositor you are using. Defaults to hyprland.
	##	compositor = "hyprland";
		# This sets up the entire matugen config & templates.
		# If you already have matugen set up you may want to omit this.
		# To use the hyprland/hyprlock templates, you would still need to
		# import the generated files and add the color aliases to your config as desired.
	##	matugenConfig = true;
	##};


	services.hyprpaper.enable = true;
	services.mako.enable = true;
	services.network-manager-applet.enable = true;

	programs.git = {
		enable = true;
		settings.user = {
			name = "AS2127";
			email = "s303557@gmail.com";
		};
	};

	programs.gh = {
		enable = true;
		gitCredentialHelper.enable = true;
	};

	programs.fish = {
		enable = true;
		interactiveShellInit = "set fish_greeting";
		generateCompletions = false;
		shellAliases = {
			cls = "clear";
			ff = "fastfetch";
		};
	};
	programs.man.enable = false;
	fonts.fontconfig.enable = false;
	home.stateVersion = "25.05";
}
