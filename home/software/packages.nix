{ pkgs, self', ... }: {
  home.packages = with pkgs; [
    # messaging
    #webcord

    pavucontrol
    neovim-unwrapped
    betterdiscordctl
    xfce.thunar
    xfce.thunar-archive-plugin
    ps_mem
    pulseaudio
    obsidian

    # misc
    libnotify
    xdg-utils
    colord
    ffmpegthumbnailer
    imagemagick
    xfce.tumbler
    xdotool
    cliphist
    rizin
    xcolor
    htop
    blueberry
    bluez
    networkmanager
    networkmanagerapplet

    glow
    # libsixel # image support for foot

    neofetch
    gnome.file-roller

    # nvim servers
    nixfmt
    rnix-lsp
    deno

    # Programming languages
    cargo
    gcc
    nodejs
    nodePackages.pnpm

    # java
    jdk17

    # python
    python311
  ];
}
