{ config, pkgs, inputs, output, ... }:

{
users.users.rdean = {
  isNormalUser = true;
  home  = "/home/rdean";
  description  = "Raymond Dean III";
  extraGroups  = [ "wheel" "networkmanager" ];
};
  # TODO please change the username & home directory to your own
  home.username = "rdean";
  home.homeDirectory = "/home/rdean";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };
  home-manager.users.rdean = {
    home.homeDirectory = "/home/rdean";
    home.packages = with pkgs; [
      nnn # terminal file manager
      # misc
      cowsay
      file
      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg
      nix-output-monitor
      btop  # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      lsof # list open files
      sysstat
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb
      tmux
      htop 
    ];
    home.stateVersion = "24.05";

  };
  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    #shellAliases = {
    #  k = "kubectl";
    #  urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    #  urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    #};
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.

  # Let home Manager install and manage itself.
  #programs.home-manager.enable = true;
}