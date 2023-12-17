# QTILE Groups Settings
# by ricardev2023

# https://docs.qtile.org/en/stable/manual/config/groups.html

# A group is a container for a bunch of windows, analogous to workspaces in other window managers. 
# Each client window managed by the window manager belongs to exactly one group. 
# The groups config file variable should be initialized to a list of DGroup objects.

# Groups can be configured to show and hide themselves when they're not empty, 
# spawn applications for them when they start, automatically acquire certain groups, 
# and various other options.

from libqtile.config import Group, Match, Key
from libqtile.command import lazy
from .keys import keys, mod

# Instead of numerating the groups I am going to use glyphs (could be more than 5):
# https://www.nerdfonts.com/cheat-sheet
# You need a Nerd Font installed.
# 1. nf-dev-terminal
# 2. nf-dev-firefox
# 3. nf-fae-layers
# 4. nf-oct-file_directory
# 5. nf-fa-crosshairs

# To identify wm_class, use the command xprop WM_CLASS
groups = [
    Group(" Terminal" , layout='bsp'), 
    Group(" Browser"  , layout='max'      , matches=[Match(wm_class='firefox-esr'), Match(wm_class='google-chrome-stable')]), 
    Group("󰖟 Burpsuite", layout='max'      , matches=[Match(wm_class='burp-StartBurp')]), 
    Group(" Debugger" , layout='max'), 
    Group(" Folders"  , layout='columns'),
    Group(" VPN"      , layout='bsp'), 
    Group(" Misc 1"   , layout='bsp'), 
    Group(" Misc 2"   , layout='bsp'),  
    Group(" Misc 3"   , layout='bsp')
    ]

for i, group in enumerate(groups):
    key_number = str(i + 1)
    keys.extend([
        # Switch to group:
        Key([mod], key_number, lazy.group[group.name].toscreen()),
        # Move Window to group:
        Key([mod, "shift"], key_number, lazy.window.togroup(group.name)),
    ])
