{ self, inputs, ... }: {
  flake.nixosModules.incus =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.local.incus;
    in
    {
      config = lib.mkIf cfg.enable {
        virtualisation.incus = {
          enable = true;
          ui.enable = true;
        };
        networking.nftables.enable = true;
        networking.firewall.trustedInterfaces = [ "incusbr0" ];
      };
      options.local.incus = {
        enable = lib.mkEnableOption "Enable the incus server";
      };
    };
}
