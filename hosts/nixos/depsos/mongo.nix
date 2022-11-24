{pkgs, ...}: {
  services.mongodb = {
    enable = true;
    bind_ip = "0.0.0.0";
    dbpath = "/srv/db/mongo";
  };
}
