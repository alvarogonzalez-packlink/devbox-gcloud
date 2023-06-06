let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/8670e496ffd093b60e74e7fa53526aa5920d09eb.tar.gz";
    })
    { };
in
with pkgs;
mkShell {
  packages = [
  ];
}
