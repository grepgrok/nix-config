
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];
  
  # Use the GRUB 2 boot loader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "icarus";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set the time zone
  time.timeZone = "America/Los_Angeles";

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.ben = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
    ];
  };
 
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    sharedModules = [ inputs.self.outputs.homeManagerModules.default ];

    users."ben" = import ./home.nix;
  };

  ################# PACKAGES & PROGRAMS ########################
  nixpkgs.config.allowUnfree = true;

  ######### Hyprland ##########
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Desktop portals (screen sharing, link opening, etc.)
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # TODO: many other options

  ######### Other ##########
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.nm-applet.enable = true;

  # List packages installed in system profile
  # TODO: mix `with pkgs;` and non-pkgs?
  environment.systemPackages = with pkgs; [
    wget
    git

    firefox
    discord

    # wezterm # TODO: this should be fixed soon
    alacritty

    waybar
    dunst # notification daemon
      libnotify
    swww # wallpaper daemon (TODO: ceck other options)
    rofi-wayland # TODO: app launcher
    networkmanagerapplet
    grim         # screnshot util --+
    slurp        # select util      |
    wl-clipboard # xlip alt       --+
  ];

  ######################## NO-TOUCHY ZONE ############################
  system.stateVersion = "24.05";
}

