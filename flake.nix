{
  description = "A flake.nix package for google cloud sdk package with auth plugin installed";

  inputs = {
    nixunstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/34a626458d686f1b58139620a8b2793e9e123bba";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , nixunstable
    , flake-utils
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      unstablepkgs = nixunstable.legacyPackages.${system};
      gems = unstablepkgs.bundlerEnv {
          name = "gems";
          ruby = pkgs.ruby;
          gemfile = ./bashly/Gemfile;
          lockfile = ./bashly/Gemfile.lock;
          gemset = ./bashly/gemset.nix;
        };
    in
    {
      packages = {
        gce = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
          gke-gcloud-auth-plugin
          kpt
          config-connector
          cloud_sql_proxy
          cbt
          pubsub-emulator
        ]);
        packlink-telepresence = pkgs.stdenv.mkDerivation {
          name = "kubectl-presence";
          version = "v1.1.0";
          src = builtins.fetchGit {
            url= "git@github.com:packlink-dev/packlink-telepresence.git";
            ref = "refs/tags/v1.1.0";
            narHash = "sha256-JhjhtU7vmvs1+gDn6HJnbJNflNDNPe963NA1rrJXRI0=";
            # nix-prefetch-git --url git@github.com:packlink-dev/packlink-telepresence.git --rev refs/tags/v1.1.0 --quiet
            };
          nativeBuildInputs = [ pkgs.bash unstablepkgs.ruby gems ];
          buildInputs = [ pkgs.bash ];
          buildPhase = ''ls'';
          installPhase = ''
          ls
          # echo "#!/bin/bash\necho 'Hello, World!'" > $out/bin/kubectl-presence
          chmod +x $out/bin/kubectl-presence
          '';
        };
      };
    });
}
