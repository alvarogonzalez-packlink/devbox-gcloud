# Looked for the hash in
# - https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=google-cloud-sdk
# - https://www.nixhub.io/packages/google-cloud-sdk
let
  pkgs = import
    (fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/34a626458d686f1b58139620a8b2793e9e123bba.tar.gz";
    })
    { };
in
with pkgs;
mkShell {
  packages = [
  ];
}
