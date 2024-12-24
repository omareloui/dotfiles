# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # nodejs = prev.nodejs.overrideAttrs (oldAttrs: {
    #   postFixup =
    #     (oldAttrs.postFixup or "")
    #     +
    #     /*
    #     bash
    #     */
    #     ''
    #       wrapProgram $out/bin/node \
    #         --set PRISMA_QUERY_ENGINE_BINARY "${prev.prisma-engines}/bin/query-engine" \
    #         --set PRISMA_MIGRATION_ENGINE_BINARY "${prev.prisma-engines}/bin/migration-engine" \
    #         --set PRISMA_INTROSPECTION_ENGINE_BINARY "${prev.prisma-engines}/bin/introspection-engine" \
    #         --set PRISMA_FMT_BINARY "${prev.prisma-engines}/bin/prisma-fmt"
    #     '';
    #   buildInputs = (oldAttrs.buildInputs or []) ++ [prev.makeWrapper];
    # });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
