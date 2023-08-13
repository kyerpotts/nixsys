{
  colorlib, lib,
}: rec {
  colors = import ./colors.nix;
  # #RRGGBB
  xcolors = lib.mapAttrs (_: colorlib.x) colors;
  # rgba(,,,) colors (css)
  rgbaColors = lib.mapAttrs (_: colorlib.rgba) colors;

  browser = "firefox";

  launcher = "anyrun";

  terminal = {
  font = "JetBrainsMono Nerd Font";
  name = "wezterm";
  opacity = 0.8;
  size = 16;
  };

  wallpaper = "~/Wallpapers/waterfall.gif";

  # wallpaper = builtins.fetchurl rec {
  #   name = "wallpaper-${sha256}.gif";
  #   # url = "https://raw.githubusercontent.com/redyf/wallpapers/main/waterfall.gif";
  #   url = "~/Wallpapers/waterfall.gif";
  #   sha256 = "cf41761fa61a80101fdb31eb96abbafa9a0a6370f060d29055f25c75bcf0cf42";
  # };
}
