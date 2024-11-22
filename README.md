# A flake.nix package for google cloud sdk with components

## How to use

1. Install devbox
2. In an empty directory run `devbox init`
3. Add this repo to your devbox project `devbox add github:alvarogonzalez-packlink/devbox-gcloud#gce`
4. Go to your devbox shell: `devbox shell`
5. Check the list of installed components: `gcloud components list`

## Customization

You can customize this flake by editing the flake.nix file. But make sure to regenerate the flake.lock file by running

```bash
nix flake update --extra-experimental-features nix-command --extra-experimental-features flakes
```

### Package name

Editing the package name results in change in command to install this package. For example, if you change the package name to `foo`, the command to install this package will become: `devbox add github:alvarogonzalez-packlink/devbox-gcloud#foo`

To change the package name, edit the value `gce = ...` in flake.nix file under `packages = {`.

### Install other gcloud components

To install more google cloud sdk components, update the line in flake.nix similar to below:

```nix
packages = {
    gce = pkgs.google-cloud-sdk.withExtraComponents ([pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin pkgs.google-cloud-sdk.components.terraform-tools]);
        };

```

Note that the items in suare brackets are separated by space.
