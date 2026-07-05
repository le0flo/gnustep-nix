{
  lib,
  pkgs,
}:

lib.makeScope pkgs.newScope (self: let
  dockapps-packages = lib.genAttrs
    (builtins.map
      (x: lib.removeSuffix ".nix" x)
      (builtins.filter
        (x: x != "package.nix")
        (builtins.attrNames (builtins.readDir ./.))))
    (name: self.callPackage ./${name}.nix {});
in {
  dockapps-sources = {
    pname = "dockapps-sources";
    version = "2025-1-1";

    src = pkgs.fetchFromRepoOrCz {
      repo = "dockapps";
      rev = "62c0416286dd7c3ae550c68b9635dd305c83f51b";
      hash = "sha256-pVyyvYZj9ANUMqXJe2Ky4otgV7wsfLcnWNCgaJXL578=";
    };
  };
}
// dockapps-packages)
