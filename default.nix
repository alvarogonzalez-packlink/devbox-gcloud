# Looked for the hash in https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=google-cloud-sdk
let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
    })
    { };
in
with pkgs;
mkShell {
  packages = [
  ];
}
