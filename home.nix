{ pkgs, inputs, ... }: {
	imports = [ inputs.neovim.homeModules.default ];

	home = {
		username = "aryan";
		homeDirectory = "/home/aryan";
	};

	neovim = {
		enable = true;
	};

	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = builtins.readFile ./hyprland.conf;
	};
	
	gtk.enable = true;

	# packages installed at the user level (https://search.nixos.org/packages)
	# *bluez-utils
	home.packages = with pkgs; [
		bluez-tools
		fzf
		btop
		discord-canary
		fastfetch
		google-chrome
		brightnessctl
		wasistlos
		inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar
		vscode
		tree
		bluez
		grim
		slurp
		swappy
		wofi
		networkmanager_dmenu
		hyprpaper
		inputs.clipse-gui.packages.${pkgs.system}.default
	];

	programs.ghostty.enable = true;

	programs.firefox.enable = true;

	services.hyprpaper.enable = true;
	services.mako.enable = true;
	services.network-manager-applet.enable = true;

	programs.git = {
		enable = true;
		userName = "AS2127";
		userEmail = "s303557@gmail.com";
	};

	programs.gh = {
		enable = true;
		gitCredentialHelper.enable = true;
	};

	programs.fish = {
		enable = true;
		interactiveShellInit = "set fish_greeting";
		shellAliases = {
			cls = "clear";
			ff = "fastfetch";
		};
	};

	home.stateVersion = "24.11";
}
