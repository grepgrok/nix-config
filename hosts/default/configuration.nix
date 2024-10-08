
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

  # Enable auto-upgrades
  # Check timer status: systemctl status nixos-upgrade.timer
  # Print upgrade log: systemvtl status nixos-upgrade.service
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # Automatically starts ssh-agent
  programs.ssh.startAgent = true;

  # Enable polkit
  # This lets non-privileged process communicate with privileged ones at a more granular level
  security.polkit.enable = true;

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

  # Display Manager
  # services.displayManager.enable = true; ?
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-latte";
    package = pkgs.kdePackages.sddm;
  };

  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.ben = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
    ];
    shell = pkgs.zsh;
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
  xdg.portal.extraPortals =
    [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ]; # TODO: find out what makes these different

  ######### Other ##########
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.nm-applet.enable = true;
  
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    wget
    git
    (catppuccin-sddm.override {
      flavor = "latte";
      font = "Noto Sans";
      fontSize = "9";
      background = "~/Wallpapers/dead-robot.jpg";
      loginBackground = true;
    })

    firefox
    discord

    # wezterm # TODO: this should be fixed soon
    alacritty

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

