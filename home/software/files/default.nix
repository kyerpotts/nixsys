{ pkgs, config, lib, ... }:
# manage files in ~
{
  imports = [ ./wlogout.nix ];

  # home.file.".config" = {
  #   source = ./config;
  #   recursive = true;
  # };

  xdg.configFile = {
    "btop/themes/catppuccin_mocha.theme".source = pkgs.fetchurl {
      url =
        "https://raw.githubusercontent.com/catppuccin/btop/7109eac2884e9ca1dae431c0d7b8bc2a7ce54e54/themes/catppuccin_mocha.theme";
      hash = "sha256-KnXUnp2sAolP7XOpNhX2g8m26josrqfTycPIBifS90Y=";
    };
  };

  # # Product Sans font
  # home.file."${config.xdg.dataHome}/fonts/Cartograph-CF-NF".source = lib.cleanSourceWith {
  #   filter = name: _: (lib.hasSuffix ".otf" (baseNameOf (toString name)));
  #   src = pkgs.fetchzip {
  #     url = "git@github.com:linuxmobile/cartograph/raw/main/Cartograph-CF-NF.zip";
  #     sha256 = "sha256-PF2n4d9+t1vscpCRWZ0CR3X0XBefzL9BAkLHoqWFZR4=";
  #     stripRoot = false;
  #   };
  # };
}
