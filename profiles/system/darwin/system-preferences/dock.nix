{
  config,
  lib,
  pkgs,
  ...
}: {
  system.defaults.dock = {
    autohide = true;
    autohide-delay = "0";
    autohide-time-modifier = "0";
    dashboard-in-overlay = false;
    enable-spring-load-actions-on-all-items = false;
    expose-animation-duration = "0.1";
    expose-group-by-app = false;
    launchanim = false;
    mineffect = "genie";
    minimize-to-application = true;
    mouse-over-hilite-stack = true;
    mru-spaces = false;
    orientation = "left";
    show-process-indicators = true;
    show-recents = false;
    showhidden = true;
    static-only = true;
    tilesize = 60;
    wvous-bl-corner = null;
    wvous-br-corner = null;
    wvous-tl-corner = null;
    wvous-tr-corner = null;
  };
}
