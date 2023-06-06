{
  description = "A devbox shell";

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
        pkgs = (import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
        nixpkgs-8670e4-pkgs = (import nixpkgs-8670e4 {
          inherit system;
          config.allowUnfree = true;
        });
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            (nixpkgs-8670e4-pkgs.google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
          ];
        };
      }
    );
}
