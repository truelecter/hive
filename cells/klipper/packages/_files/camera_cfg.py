import mpv
import logging
import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk
from contextlib import suppress
from ks_includes.screen_panel import ScreenPanel

# TODO: move this thing into public someday
class Panel(ScreenPanel):
    def __init__(self, screen, title):
        super().__init__(screen, title)
        self.mpv = None
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)

        self.scroll = self._gtk.ScrolledWindow()
        self.scroll.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC)
        self.scroll.add(box)
        self.content.add(self.scroll)
        self.content.show_all()

        self.cam = {
          "stream_url": screen._config.config.get("include nozzle_cam", "url"),
          "flip_horizontal": screen._config.config.get("include nozzle_cam", "flip_horizontal", fallback=0),
          "flip_vertical": screen._config.config.get("include nozzle_cam", "flip_vertical", fallback=0),
          "rotation": screen._config.config.get("include nozzle_cam", "rotation", fallback=0),
        }

    def activate(self):
        self.play(None, self.cam)

    def deactivate(self):
        if self.mpv:
            self.mpv.terminate()
            self.mpv = None

    def play(self, widget, cam):
        url = cam['stream_url']
        if url.startswith('/'):
            logging.info("camera URL is relative")
            endpoint = self._screen.apiclient.endpoint.split(':')
            url = f"{endpoint[0]}:{endpoint[1]}{url}"
        vf = ""
        if cam["flip_horizontal"]:
            vf += "hflip,"
        if cam["flip_vertical"]:
            vf += "vflip,"
        vf += f"rotate:{cam['rotation']*3.14159/180}"
        logging.info(f"video filters: {vf}")

        if self.mpv:
            self.mpv.terminate()
        self.mpv = mpv.MPV(fullscreen=True, log_handler=self.log, vo='gpu,wlshm,xv,x11')

        self.mpv.vf = vf

        with suppress(Exception):
            self.mpv.profile = 'sw-fast'

        # LOW LATENCY PLAYBACK
        with suppress(Exception):
            self.mpv.profile = 'low-latency'
        self.mpv.untimed = True
        self.mpv.audio = 'no'

        @self.mpv.on_key_press('MBTN_LEFT' or 'MBTN_LEFT_DBL')
        def clicked():
            self.mpv.quit(0)

        logging.debug(f"Camera URL: {url}")
        self.mpv.play(url)

        try:
            self.mpv.wait_for_playback()
        except mpv.ShutdownError:
            logging.info('Exiting Fullscreen')
        except Exception as e:
            logging.exception(e)
        self.mpv.terminate()
        self.mpv = None

        self._screen._menu_go_back()

    def log(self, loglevel, component, message):
        logging.debug(f'[{loglevel}] {component}: {message}')
        if loglevel == 'error' and 'No Xvideo support found' not in message and 'youtube-dl' not in message:
            self._screen.show_popup_message(f'{message}')
