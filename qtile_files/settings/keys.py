# QTILE Keybinding Settings
# by strelock

# https://docs.qtile.org/en/stable/manual/config/keys.html

# The keys variable defines Qtile's key bindings. 
# Individual key bindings are defined with libqtile.config.Key

from libqtile.config import Key
from libqtile.command import lazy
from libqtile.utils import guess_terminal

# Modifiers are special keys that are used in Keybindings, they could be:
# shift       Shift_L (0x32),  Shift_R (0x3e)
# lock        Caps_Lock (0x42)
# control     Control_L (0x25),  Control_R (0x69)
# mod1        Alt_L (0x40),  Alt_R (0x6c),  Meta_L (0xcd)
# mod2        Num_Lock (0x4d)
# mod3        Not_defined
# mod4        Super_L (0x85),  Super_R (0x86),  Super_L (0xce),  Hyper_L (0xcf)
# mod5        ISO_Level3_Shift (0x5c),  Mode_switch (0xcb)
mod = "mod4"
# This util allows to define which terminal is used.
terminal = guess_terminal()

# For special keys see: 
# https://raw.githubusercontent.com/qtile/qtile/master/libqtile/backend/x11/xkeysyms.py 

# A list of available commands that can be bound to keys can be found at:
# https://docs.qtile.org/en/latest/manual/config/lazy.html

keys = [
    # --------------- Window config ---------------

    # Switch between windows 
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    # Moving out of range verticaly in current stack has no effect. 
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    
    # Reset all window sizes. 
    Key([mod, "control"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), 
        desc="Toggle between split and unsplit sides of stack"),

    # Toggle floating
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),

    #Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle next layout"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Toggle previous layout"),

    # Kill window
    Key([mod], "q", lazy.window.kill(), desc="Kill Window"),

    # Switch focus of monitors (Not in use now)
    # ([mod], "period", lazy.next_screen(), desc="Focus on next screen"),
    # ([mod], "comma", lazy.prev_screen(), desc="Focus on previous screen"),

    # Restart Qtile
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    
    # Quit Qtile
    Key([mod, "control"], "q", lazy.shutdown(), desc="Quit Qtile"),

    # --------------- Applications ---------------

    # Terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    
    # Firefox
    Key([mod], "f", lazy.spawn("firefox"), desc="Launch firefox"),
    
    # Google Chrome
    Key([mod], "g", lazy.spawn("google-chrome-stable"), desc="Launch chrome"),
    
    # IDA Pro Decompiler
    Key([mod], "i", lazy.spawn("ida64"), desc="Launch ida pro decompiler"),

    # GHIDRA Decompiler
    Key([mod], "d", lazy.spawn("ghidra"), desc="Launch ghidra decompiler"),
    
    # Burpsuite
    Key([mod], "b", lazy.spawn("burpsuite"), desc="Launch Burpsuite"),

    # Rofi
    Key([mod], "m", 
    lazy.spawn("rofi -no-lazy-grab -show drun -modi drun -theme /home/strelock/.config/rofi/launchers/misc/launchpad"), 
    desc="Launch rofi"),
    
    # Dolphin
    Key([mod], "a", lazy.spawn("dolphin --platformtheme qt5ct"), desc="Launch dolphin"),

    # Gnome-Calculator
    Key([mod], "c", lazy.spawn("gnome-calculator"), desc="Launch gnome calculator"),

    # --------------- Hardware Configs ---------------

    # Volume (Not in use on my config)
    # Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    # Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    # Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),

    # Brightness (Not in use on my config)
    # Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    # Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
]
