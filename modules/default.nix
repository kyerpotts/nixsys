{ self, inputs, default, ... }:
let
  #system-agnostic args
  module_args._module.args = { inherit default inputs self; };
  in {
    imports = [{
      _module.args = {
        # This needs to be passed to HM
        inherit module_args;

        #NixOS modules
        sharedModules = [
          { home-manager.useGlobalPkgs = true; }
          inputs.agenix.nixosModules.default
          inputs.hm.nixosModule
          inputs.hyprland.nixosModules.default
          module_args
          ./system.nix
          ./security.nix
          ./greetd.nix
          ./nix.nix
        ];
      };
    }];

    flake.nixosModules = {
      core = import ./system.nix;
      desktop = import ./desktop.nix;
      greetd = import ./greetd.nix;
      nix = import ./nix.nix;
    };
  }
