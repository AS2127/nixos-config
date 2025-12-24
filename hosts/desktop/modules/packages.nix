{pkgs, ... }: {
	environment.systemPackages = with pkgs; [
    	ghostty
    	git
    	neovim
    	nano
    	pavucontrol

  ];

	fonts.packages = with pkgs; [ jetbrains-mono google-fonts ];

	}
