
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "icarus"; # Define your hostname.
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Enable Hyprland
  programs.hyprland.enable = true;


  programs.hyprland.xwayland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  # Desktop portals (screen sharing, link opening, file opening, etc.)
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # TODO: many other options  

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;  

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  #services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ben = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
    ];
    #shell = pkgs.zsh;
  };
 
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    #sharedModules = [ inputs.self.outputs.hm-modules.default ];

    users."ben" = import ./home.nix;
  };

  nixpkgs.config.allowUnfree = true;  

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.nm-applet.enable = true;

  #programs.zsh.enable = true;
  #users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile.
  # TODO: mix with pkgs and non-pkgs packages?
  environment.systemPackages = with pkgs; [
    wget
    git

    firefox
    discord
    
    # NOTE: it is vitally important for any packages in hyprland.conf to be downloaded
    # TODO: since hyprland.conf is user specific, is their breakiness user specific? test with home manager
    # terminal
    #wezterm #TODO: this should be fixed soon
    alacritty

    waybar
    dunst # notification daemon
      libnotify
    swww # wallpaper daemon (TODO: check other options)
    rofi-wayland # TODO: app launcher
    networkmanagerapplet
    grim         # screenshot util --+
    slurp        # select util       |
    wl-clipboard # xclip alt       --+
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

