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
from libqtile.lazy import lazy
from .keys import keys, mod

# Instead of numerating the groups I am going to use glyphs (could be more than 5):
# https://www.nerdfonts.com/cheat-sheet
# You need a Nerd Font installed.
# 1. nf-dev-terminal
# 2. nf-dev-firefox
# 3. nf-fae-layers
# 4. nf-oct-file_directory
# 5. nf-fa-crosshairs


groups = [Group(i) for i in [" Terminal", " Firefox", " Chrome", " Debugger", " Folders", " VPN", " Misc 1", " Misc 2", " Misc 3"]]

for i, group in enumerate(groups):
    key_number = str(i + 1)
    keys.extend([
        # Switch to group:
        Key([mod], key_number, lazy.group[group.name].toscreen()),
        # Move Window to group:
        Key([mod, "shift"], key_number, lazy.window.togroup(group.name)),
    ])
