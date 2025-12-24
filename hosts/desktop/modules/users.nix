{ pkgs, ... }: {
	
  users.users.aryan = {
    isNormalUser = true;
    description = "Aryan";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.fish;
  };


	}
