{
  services.zabbixAgent = {
    enable = true;
    server = "zabbix-px01.deps.ua,192.168.20.27";
    openFirewall = true;
    settings = {
      Hostname = "vs-kv-net-we11";
      ServerActive = "zabbix-px01.deps.ua,192.168.20.27";
    };
  };
}
