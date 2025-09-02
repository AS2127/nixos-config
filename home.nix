{ pkgs, inputs, ... }: {
	home = {
		username = "aryan";
		homeDirectory = "/home/aryan";
	};

	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = builtins.readFile ./hyprland.conf;
	};

	# packages installed at the user level (https://search.nixos.org/packages)
	home.packages = with pkgs; [
		btop
		discord-canary
		fastfetch
		google-chrome
	];
	programs.ghostty.enable = true;
	programs.firefox.enable = true;

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

	programs.neovim.enable = true;

	home.stateVersion = "24.11";
}
