{self, ...}: {
	flake.nixosModules.tailscale = {pkgs, ...}: {
		services.tailscale = {
			enable = true;
			useRoutingFeatures = "server";
			extraDaemonFlags = [ "--no-logs-no-support" ];
		};
		
	};
}
