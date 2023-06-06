{
  description = "A flake.nix package for google cloud sdk package with auth plugin installed";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/8670e496ffd093b60e74e7fa53526aa5920d09eb";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-8670e4.url = "github:NixOS/nixpkgs/8670e496ffd093b60e74e7fa53526aa5920d09eb";
  };

  outputs = { 
    self,
    nixpkgs,
    nixpkgs-8670e4,
    flake-utils 
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          gce = pkgs.google-cloud-sdk.withExtraComponents ([pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin]);
        };
      });
}
