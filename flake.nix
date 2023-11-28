{
  description = "A flake.nix package for google cloud sdk package with auth plugin installed";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/9957cd48326fe8dbd52fdc50dd2502307f188b0d";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-9957cd.url = "github:NixOS/nixpkgs/9957cd48326fe8dbd52fdc50dd2502307f188b0d";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-9957cd
    , flake-utils
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages = {
        gce = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
          gke-gcloud-auth-plugin
          kpt
          config-connector
          cloud_sql_proxy
          cbt
        ]);
      };
    });
}
