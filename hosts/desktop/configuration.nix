{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

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
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };

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

  # User
  users.users.aryan = {
    isNormalUser = true;
    description = "Aryan";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.fish;
  };

  # Fish shell
  programs.fish.enable = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Display manager (simple text login)
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      user = "greeter";
    };
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Graphics
  hardware.graphics.enable = true;

  # Polkit
  security.polkit.enable = true;

  # Printing
  services.printing.enable = true;

  # BAREBONES packages
  environment.systemPackages = with pkgs; [
    ghostty
    git
    neovim
    nano
    pavucontrol

  ];

  fonts.packages = with pkgs; [ jetbrains-mono ];
  
  system.stateVersion = "25.11";
}
