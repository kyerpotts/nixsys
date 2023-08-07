{
  systems = [ "x86_64-linux" ];

  perSystem = { pkgs, ... }: {
    packages = {
      # instant repl with automatic flake loading
      repl = pkgs.callPackage ./repl { };

      catpuccin-plymouth = pkgs.callPackage ./catpuccin-plymouth { };

      xwaylandvideobridge =
      pkgs.libsForQt5.callPackage ./xwaylandvideobridge { };
    }
  }
}
