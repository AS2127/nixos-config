{ pkgs, inputs, lib, ... }: {
  imports = [ 
  	./neovim
	./apps.nix
  ];

  home = {
    username = "aryan";
    homeDirectory = "/home/aryan";
  };


  gtk = {
	  enable = true;

	  cursorTheme = {
		  name = "Oxygen-17-Black";
		  size = 24;
	  };
  };

  qt = {
		enable = true;
		platformTheme.name = "gtk";
  };

  neovim = {
  	enable = true;
  };

  # Git config
  programs.git = {
    enable = true;
    userName = "AS2127";
    userEmail = "s303557@gmail.com";
  };

  # Fish shell
  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos-desktop";
      update = "cd ~/nixos-config && nix flake update && rebuild";
      cls = "clear";
    };
  };

  # Ghostty terminal
  programs.ghostty.enable = true;

  
  home.stateVersion = "25.05";
}
