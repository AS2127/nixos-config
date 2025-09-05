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

	xdg.configFile."waybar/config.jsonc".source = ./waybar.jsonc;

	# packages installed at the user level (https://search.nixos.org/packages)
	home.packages = with pkgs; [
		btop
		discord-canary
		fastfetch
		google-chrome
		brightnessctl
		wasistlos
		waybar
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
