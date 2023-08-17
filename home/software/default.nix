{ pkgs, config, ... }: {
  imports = [
    ../shell/nix.nix
    ./wezterm.nix
    ./cava.nix
    ./neofetch.nix
    ./dunst.nix
    ./files
    ./firefox
    ./media.nix
    ./git.nix
    ./gtk.nix
    ./packages.nix
    # ./spotify-player.nix
    ./qt.nix
    ./spicetify.nix
    ./xdg.nix
    ./zathura.nix

    # Apps
    ./webcord/default.nix
  ];

  programs = {
    firefox = {
      enable = true;
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };

    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
      settings.PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
    };

    syncthing.enable = true;
  };
}
