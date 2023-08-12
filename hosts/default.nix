{ inputs, withSystem, sharedModules, homeImports, ... }:
{
  flake.nixosConfigurations = withSystem "x86_64-linux"
  ({ system, self', inputs', ... }:
    let
      systemInputs = { _module.args = { inherit self' inputs'; };};
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in {
      tidepool = nixosSystem {
        inherit system;

        modules = [
          ./tidepool
          ../modules/desktop.nix
          # ../modules/greetd.nix
          {
            home-manager.users.squidmilk.imports =
              homeImports."squidmilk@tidepool";
          }
          systemInputs
        ] ++ sharedModules;
      };
    });
}
