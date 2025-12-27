{pkgs, ...}: {
  home.packages = with pkgs; [
	firefox
	google-chrome
	kdePackages.dolphin
	hyprlauncher
	vesktop
	youtube-music
	htop
	btop
	fzf
	wget
	tree
	mako
	xcursor-themes
	gparted
	bluetooth_battery
	bluetui
	blueman
	clipse
	clipse-gui
	wl-clipboard
	grim
	slurp
	geeqie
  ];

  home.sessionVariables = {
	  XCURSOR_THEME = "Oxygen-17";
	  XCURSOR_SIZE = "24";
  };
}

 
