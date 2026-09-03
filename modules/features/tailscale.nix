{ self, ... }: {
  flake.nixosModules.tailscale =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.local.tailscale;
    in
    {
      options.local.tailscale = {
        enable = lib.mkEnableOption "Enable the tailscale server";
      };

      config = lib.mkIf cfg.enable {
        services.tailscale = {
          enable = true;
          useRoutingFeatures = "server";
          extraDaemonFlags = [ "--no-logs-no-support" ];
        };
      };

    };
}
