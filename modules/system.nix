{ pkgs, lib, ... }:
# configurations shared between hosts
{
  environment.pathsToLink = [ "/share/zsh" ];

  time.timeZone = lib.mkDefault "Australia/Perth";

  i18n = {
    defaultLocale = "en_AU.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "en_AU.UTF-8/UTF-8" ];
  };

  # Configure console keymap
  console.keyMap = "us";

  # Hardware acceleration
  hardware.opengl.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable ssh
  services.openssh.enable = true;


  # enable programs
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        patterns = { "rm -rf *" = "fg=black, bg=red"; };
        styles = { "alias" = "fg=magenta"; };
        highlighters = [ "main" "brackets" "pattern" ];
      };
    };
  };

  # Don't ask for password for wheel group
  security.sudo.wheelNeedsPassword = false;

  users.users.squidmilk = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "input" "libvirtd" "networkmanager" "plugdev" "video" "wheel" ];
  };

  # compresses half the ram for use as swap
  zramSwap.enable = true;

  # don't touch this
  system.stateVersion = lib.mkDefault "23.05";
}
