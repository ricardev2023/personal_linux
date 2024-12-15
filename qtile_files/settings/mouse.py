# QTILE Mouse Settings
# by ricardev2023

# The mouse config file variable defines a set of global mouse actions, 
# and is a list of Click and Drag objects, 
# which define what to do when a window is clicked or dragged.

from libqtile.config import Drag, Click
from libqtile.lazy import lazy
from .keys import mod


mouse = [
    # Move a floating window arround
    # With left click and drag.
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),

    # Set size of a floating window
    # With right click and drag.
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),

    # Bring to front a floating window
    # with center click.
    Click([mod], "Button2", lazy.window.bring_to_front())
]
