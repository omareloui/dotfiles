{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  services.cron = {
    enable = lib.mkDefault true;
    systemCronJobs = [
      "0 0 */1 * * ${config.users.users.omareloui.name} ${outputs.packages.${pkgs.stdenv.hostPlatform.system}.cloud_backup}"
    ];
  };
}
