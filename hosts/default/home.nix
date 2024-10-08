{ config, pkgs, inputs, ... }:

{
  imports = [ 
    inputs.self.outputs.homeManagerModules.default 
    inputs.ags.homeManagerModules.default
    ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true; # Let Home Manager install and maange itself

  # The home.packages option allows you to install Nix packages into your environment
  home.packages = [
    pkgs.alacritty
    pkgs.clipse
    #pkgs.pactl

    # # it is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfont.override { fonts = [ "FantasqueSansMono" ]; })
    # Compile waybar with experimental option
    #(waybar.overrideAttrs (oldAttrs: {
    #  mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true" ];
    #}))

    # # You can also create simple shell scripts directly inside your configuration.
    # # For example, this adds a command `my-hello` to you environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  ags.enable = true;
  alacritty.enable = true;
  clipse.enable = true;
  git.enable = true;
  hypr.enable = true;

  home.pointerCursor = {
    # or "phinger-cursors-dark"
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32; # opt: 24, 32, 48, 64, 96, 128
    gtk.enable = true;
  };
  
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.waybar = {
    enable = true;
  };

  zsh.enable = true;

  # Home Manager is pretty good at managing dotfiles. the primary way to manage
  # plain files is through `home.file`.
  home.file = {
    # # Building this configuration will create a copy of `dotfiles/screenrc` in
    # # the Nix store. Activating the configuration will them make `~/.screenrc` a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=360000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # `home.sessionVariables`. These will be explicitly sources when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source `hm-session-vars.sh`
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ben/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
