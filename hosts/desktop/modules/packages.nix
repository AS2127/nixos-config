{pkgs, ... }: {
	environment.systemPackages = with pkgs; [
    	ghostty
    	git
    	neovim
    	nano
    	pavucontrol
		adwaita-icon-theme
		papirus-icon-theme
		hicolor-icon-theme

  ];

  	environment.variables = {
		XCURSOR_THEME = "Oxygen-17-Black";
		XCURSOR_SIZE = "24";
	};

	fonts.packages = with pkgs; [ jetbrains-mono google-fonts ];

	}
