{ inputs', pkgs, self, self', ... }: {
  boot.plymouth = {
    enable = true;
    themePackages = [ self'.packages.catppuccin-plymouth ];
    theme = "catppuccin-mocha";
  };

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols
      # normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      # nerdfonts
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];

    # user defined fonts
    # Noto Color Emoji is used to override B&W emojies that would sometimes show
    fontconfig.defaultFonts = {
    serif = [ "Roboto Serif" "Noto Color Emoji" ];
    sansSerif = [ "Roboto" "Noto Color Emoji" ];
    monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
    emoji = [ "Noto Color Emoji" ];
    };
  };

  # use Wayland where possible (electron)
  environment.variables.NIXOS_OZONE_WL = "1";

  hardware = {
    # smooth backlight control
    brillo.enable = true;

    opengl = {
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  nix = {
    # package = inputs'.nix-super.packages.nix;
    settings = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://cache.privatevoid.net"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
      ];
    };
  };

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;
    # seahorse.enable = true;
  };

  services = {
    # provide location
    # geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;

    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      excludePackages = [ pkgs.xterm ];
      libinput.enable = true;
    };

    logind.extraConfig = ''
    HandlePowerKey=suspend
    '';

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;

      # lowLatency.enable = true;
    };

    # battery info
    upower.enable = true;

    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = [ pkgs.gcr ];
  };

  security = {
    # allow wayland lockers to unlock the screen
    pam.services.swaylock.text = "auth include login";

    # userland niceness
    rtkit.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
