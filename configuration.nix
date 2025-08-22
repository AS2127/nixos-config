{ config, pkgs, ... }: {
	imports = [ ./hardware-configuration.nix ];

	nixpkgs.config.allowUnfree = true; # allow closed source software

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
		hostName = "nixos";
		wireless.enable = false;
		networkmanager.enable = true;
		enableB43Firmware = true;
	};

	# enables support for broadcom wireless chips
	boot = {
		kernelModules = [
			"kvm-intel" # enables hardware virtualization on intel cpus
			"wl" # proprietary driver for broadcom wireless chips
			"b43" # open source driver for legacy broadcom wireless chips
		];
		extraModulePackages = with config.boot.kernelPackages; [
			apfs # provides readonly support for apple filesystems on linux
			broadcom_sta # proprietary driver for broadcom wireless chips
		];
	};

	# user configuration
	users.users.aryan = {
		isNormalUser = true;
		description = "Aryan";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;
	};
	programs.fish.enable = true;

	# packages installed at the system level
	environment.systemPackages = with pkgs; [ git ];

	# enable kde plasma and sddm login manager
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;

	# Enable sound with pipewire.
	# services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	# miscellaneous configuration
	time.timeZone = "America/Chicago";
	services.openssh.enable = true;
	services.printing.enable = true;
	programs.gnupg.agent.enable = true;

	# laptop specific configuration (https://nixos.wiki/wiki/Laptop)
	powerManagement.enable = true;
	services.thermald.enable = true;
	services.tlp.enable = false; # kde plasma uses ppd, a tlp alternative

	# install fonts
	fonts.packages = with pkgs; [ noto-fonts jetbrains-mono ];

	system.stateVersion = "25.05";
}
