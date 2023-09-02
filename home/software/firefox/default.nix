{ pkgs, ... }:
let
  patched-firefox = pkgs.symlinkJoin {
          name= "patched-firefox";
          paths = [ pkgs.firefox ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
                  wrapProgram "$out/bin/firefox" --set TZ /etc/localtime
          '';
  };
in
{
  home.packages = with pkgs; [
          patched-firefox
  ];
}
