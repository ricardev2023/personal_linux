# QTILE Layouts Settings
# by strelock

# https://docs.qtile.org/en/stable/manual/config/layouts.html

# A layout is an algorithm for laying out windows in a group on your screenself.
# Built-in layouts could be found in:
# https://docs.qtile.org/en/stable/manual/ref/layouts.html#ref-layouts

from libqtile import layout
from libqtile.config import Match
from .theme import colors

# General cofiguration
layout_conf = {
    'border_focus': colors['focus'][0],
    'border_width': 1,
    'margin': 4
}

# Layout list    
# For using more layouts uncomment below.
layouts = [
    layout.Columns(**layout_conf),
    layout.Max(),
    #layout.MonadTall(**layout_conf),
    #layout.MonadWide(**layout_conf),
    #layout.Bsp(**layout_conf),
    #layout.Matrix(columns=2, **layout_conf),
    #layout.RatioTile(**layout_conf),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# Floating Layout Configuration
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        # Example 
        # Match(wm_class='confirmreset'),
    ],
    border_focus=colors["color4"][0]
)
