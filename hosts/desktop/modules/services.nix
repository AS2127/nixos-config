{ pkgs, config, ... }: {
	services.greetd = {
		enable = true;
		settings.default_session = {
			command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
			user = "greeter";
		};
	};
	
	security.rtkit.enable = true;
	
	services.blueman.enable = true;
	
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	security.polkit.enable = true;

	services.printing.enable = true;


			   }
