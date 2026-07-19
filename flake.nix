{
  description = "GNUstep related projects";

  outputs = {self, nixpkgs, ...}@inputs: let
    perSystem = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "i686-linux"
      "aarch64-linux"
    ];

    callPackage = system: (pkgs system).lib.callPackageWith (pkgs system // customPkgs system);

    pkgs = system: nixpkgs.legacyPackages.${system};

    customPkgs = system: nixpkgs.lib.genAttrs
      (builtins.attrNames (builtins.readDir ./pkgs))
      (name: callPackage system ./pkgs/${name}/package.nix {});
  in {
    packages = perSystem (system: customPkgs system);

    overlays = perSystem (system: final: prev: customPkgs system);
  };

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
}
