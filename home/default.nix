{ pkgs, ... }: {
  home = {
    username = "aryan";
    homeDirectory = "/home/aryan";
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

  # Empty packages - add them yourself as you learn!
  home.packages = with pkgs; [
	firefox
	kdePackages.dolphin
	hyprlauncher
	vesktop
	youtube-music
	htop
	btop
	fzf
	wget
  ];

  home.stateVersion = "25.05";
}
