{ self, config, pkgs, inputs, inputs', lib, ... }:
{
  environment.systemPackages = [
    # git is a requirement for flakes
    pkgs.gitFull
    pkgs.libsecret
    inputs'.nh.packages.default
  ];
  # this may or may not need to be uncommented to work
  # environment.variables.FLAKE = "/home/squidmilk/.config/nixsys";

  nix = {
    distributedBuilds = true;

    # auto garbage collect
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # pin the registry to avoid downloading and evaluating a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: { flake = v; }) inputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "/etc/nix/registry.json";

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      substituters = [
        "https://nix-community.cachix.org"
        "https://fufexan.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "fufexan.cachix.org-1:LwCDjCJNJQf5XD2BV+yamQIMZfcKWR9ISIFy5curUsY="
      ];

      trusted-users = [ "root" "@wheel" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    # overlays = [
    #   (
    #     _: prev: {
    #       greetd = prev.greetd // {
    #         regreet = prev.greetd.regreet.overrideAttrs (oldAttrs: rec {
    #           version = "0.1.1-patched";
    #           src = prev.fetchFromGitHub {
    #             owner = "rharish101";
    #             repo = "ReGreet";
    #             rev = "61d871a0ee5c74230dfef8100d0c9bc75b309203";
    #             hash = "sha256-PkQTubSm/FN3FXs9vBB3FI4dXbQhv/7fS1rXkVsTAAs=";
    #           };
    #           cargoDeps = oldAttrs.cargoDeps.overrideAttrs (_: {
    #             inherit src;
    #             outputHash = "sha256-dR6veXCGVMr5TbCvP0EqyQKTG2XM65VHF9U2nRWyzfA=";
    #           });
    #
    #           patches = [ ../pkgs/regreet.patch ];
    #         });
    #       };
    #     }
    #   )
    # ];
  };
}
