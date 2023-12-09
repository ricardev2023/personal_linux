# QTILE Config file
# by strelock

# http://www.qtile.org/

from libqtile import hook

from settings.keys import mod, keys
from settings.groups import groups
from settings.layouts import layouts, floating_layout
from settings.widgets import widget_defaults, extension_defaults
# from settings.screens import screens
from settings.mouse import mouse
from settings.path import qtile_path

from os import path
import subprocess

# Autostart script only at sartup.
@hook.subscribe.startup_once
def autostart():
    subprocess.call([path.join(qtile_path, 'autostart.sh')])

# Some variables needed for a proper configuration.
main = None
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
auto_fullscreen = True
focus_on_window_activation = 'urgent'
wmname = 'LG3D'
