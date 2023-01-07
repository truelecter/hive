{
  config,
  pkgs,
  lib,
  ...
}: {
  sops.secrets.moonraker-tg-bot.owner = config.tl.services.moonraker-telegram-bot.user;

  tl.services.moonraker-telegram-bot = {
    enable = true;
    settings = {
      secrets = {
        secrets_path = config.sops.secrets.moonraker-tg-bot.path;
      };
      camera = {
        host = "rtsp://127.0.0.1:8554/cam";
        fps = 30;
      };
      timelapse = {
        height = 0.2;
        last_frame_duration = 1;
        time = 60;
        target_fps = 25;
      };
    };
  };
}
