{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ./modules ];

  # Nix settings
  nix = {
    channel.enable = false;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Bootloader (GRUB for dual boot)


  # Networking
  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Time
  time.timeZone = "America/Chicago";

  # Fish shell
  programs.fish.enable = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Display manager (simple text login)
  

  # Audio
  security.rtkit.enable = true;
  
  # Graphics
  hardware.graphics.enable = true;

  # Polkit
  security.polkit.enable = true;

  # Printing

  # BAREBONES packages

  
  system.stateVersion = "25.11";
}
