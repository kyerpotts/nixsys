{ inputs, withSystem, sharedModules, homeImports, ... }: {
  flake.nixosConfigurations = withSystem "x86_64-linux"
  ({ system, self', inputs', ... }:
    let
      systemInputs = { _module.args = { inherit self' inputs'; };};
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in {
      squidmilk = nixosSystem {
        inherit system;

        modules = [
          ./squidmilk
          ../modules/desktop.nix
          ../modules/desktop.nix
          {
            home-manager.users.squidmilk.imports =
              homeImports."squidmilk@tidepool";
          }
          systemInputs
        ] ++ sharedModules;
      };
    });
}
