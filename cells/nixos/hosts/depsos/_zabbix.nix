{
  services.zabbixAgent = {
    enable = true;
    server = "zabbix-px01.deps.ua";
    openFirewall = true;
    settings = {
      Hostname = "vs-kv-net-we11";
    };
  };
}
