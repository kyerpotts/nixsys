{ pkgs, lib, inputs', ... }:
# Wayland general config
{
  imports = [
    ./anyrun.nix
    ./hyprland
    ./waybar
    ./swayidle.nix
    ./swaylock.nix
    ./swww.nix
  ];

  home.packages = with pkgs; [
    # screenshot utilities
    grim
    slurp

    # background/idle
    swaylock-effects
    swww

    # utils
    wf-recorder
    wl-clipboard
    wlogout
    hyprpicker
    wlsunset
  ];

  # Make sessionvariables work with wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  # fake a tray to allow apps to start
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
