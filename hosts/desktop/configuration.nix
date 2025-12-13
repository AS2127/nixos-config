{ config, pkgs, ... }: {
	imports = [ ./hardware-configuration.nix ];

	nix = {
		channel.enable = false;
		settings.auto-optimise-store = true;
	};

	nixpkgs.config.allowUnfree = true; # allow closed source software
	nixpkgs.config.allowBroken = true;

	# enable nix commands flakes
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		trusted-users = [ "root" "@wheel" ];
	};


	# boot configuration
	boot.loader = {
		efi.canTouchEfiVariables = true;
		grub.efiSupport = true;
		grub.device = "nodev";
	};

	# networking configuration
	networking = {
		hostName = "nixos-desktop";
		networkmanager.enable = true;
		# wireless.enable = true; DOES NOT WORK (with KDE?)
	};

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};

	# user configuration
	users.users.aryan = {
		isNormalUser = true;
		description = "Aryan";
		extraGroups = [ "networkmanager" "wheel" "video" ];
		shell = pkgs.fish;
	};
	programs.fish.enable = true;

	# packages installed at the system level
	environment.systemPackages = with pkgs; [ firefox git vim wl-clipboard clipse gnome-keyring nautilus ];

	# enable sddm login manager with kde plasma and hyprland
	#services.displayManager.sddm = {
	#	enable = true;
	#	wayland.enable = true;
	#};
	services.displayManager.gdm = {
		enable = true;
		wayland = true;
	};
	# services.desktopManager.plasma6.enable = true;
	# services.xserver.displayManager.gdm.enable = true;
	programs.hyprland.enable = true;
	services.upower.enable = true;
	services.power-profiles-daemon.enable = true;
	# Enable sound with pipewire.
	# services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.blueman.enable = false;
	security.polkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
		wireplumber.enable = true;
	};

	# miscellaneous configuration
	time.timeZone = "America/Chicago";
	services.openssh.enable = true;
	services.printing.enable = true;
	programs.gnupg.agent.enable = true;

	# install fonts
	fonts.packages = with pkgs; [ noto-fonts jetbrains-mono font-awesome nerd-fonts._0xproto material-icons nerd-fonts.fira-code nerd-fonts.dejavu-sans-mono dejavu_fonts];

	system.stateVersion = "25.11";
}

