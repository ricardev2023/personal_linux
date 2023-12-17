# personal_linux
Simple Bash script to personalize your Linux experience with different plugins and applications.

## Installation

Installing personal_linux is very easy. Just follow the next commands.

```bash
sudo apt install git
git clone https://github.com/ricardev2023/personal_linux.git
cd ./personal_linux
chmod +x personalization.sh
./personalization.sh
```

After that you must follow the instructions printed on the screen.

## Qtile

Qtile is a window manager written and configured in Python.

### Configuration

Qtile reads its configuration from a file stored in `~/.config/qtile/config.py`. However, in this project, the configuration has been structured across different configuration files based on our needs:

#### [config.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/config.py)

This configuration file defines the most important aspects:

1. It invokes the rest of the configuration files.

2. Defines the window manager's behavior upon initial startup. It uses the `startup_once()` function, which calls the [script](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/scripts/startup_once.sh) of the same name stored in the 'scripts' folder. [qtile reference](https://docs.qtile.org/en/stable/manual/ref/hooks.html#libqtile.hook.subscribe.startup).

3. Determines the window manager's behavior after each restart (`win + ctrl + r`). This is accomplished through the `restart()` function, which calls the [script](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/scripts/restart.sh) of the same name stored in the 'scripts' folder. [qtile reference](https://docs.qtile.org/en/stable/manual/ref/hooks.html#libqtile.hook.subscribe.startup_once).

4. Sets the values of configuration variables that control specific aspects of Qtile's behavior. [qtile reference](https://docs.qtile.org/en/stable/manual/config/index.html#configuration-variables).

#### [settings.groups.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/settings/groups.py)

A group serves as a container for a collection of windows, much like workspaces in other window managers. Each window managed by the window manager is part of exactly one group. The 'groups' configuration file variable should be initialized as a list of DGroup objects. 

Groups can be configured to display or hide themselves when they're not in use, launch applications upon their creation, automatically acquire specific groups, and offer various other options. [qtile reference](https://docs.qtile.org/en/stable/manual/config/groups.html).

In this case, instead of numbering the groups, we'll use glyphs to differentiate them. This configuration file defines how many groups we'll use by employing a list. Modifying this list alters how the groups appear in the top bar.

Additionally, in this file, we define the button combination to switch between groups. This can be customized to suit your specific requirements.

#### [settings.keys.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/settings/keys.py)

The `keys` variable defines the key bindings for Qtile. Individual key bindings are defined using `libqtile.config.Key`. [qtile reference](https://docs.qtile.org/en/stable/manual/config/keys.html).

This configuration file defines:

1. The `mod` key to be utilized. The `mod` key is a special key used in all key bindings. In this case, we use `mod4`, which corresponds to the `Super` or `Win` button. However, this can be easily modified.
   
2. Key bindings used for window management configuration.
   
3. Key bindings used for accessing applications.

4. Key bindings managing hardware configurations such as volume or brightness.

==**Caution:** It's crucial to avoid repeating key bindings as this can lead to unexpected window manager behaviors. 
As a general rule, this won't cause an error; rather, the first key binding encountered in the configuration file will be executed. However, this might be challenging to debug.==

#### [settings.layouts.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/settings/layouts.py)

A layout is an algorithm that arranges windows within a group on your screen. [qtile reference](https://docs.qtile.org/en/stable/manual/ref/layouts.html#built-in-layouts).

This configuration file develops the general setup for all the built-in layouts of Qtile and selects those to be utilized. In this case, we employ 4 types:

1. **Columns**: The screen is divided into columns, which can be dynamically added or removed. Each column can display its windows in two modes: split or stacked. In split mode, all windows are visible simultaneously, dividing the column space. In stacked mode, only a single window is visible from the stack of windows. Columns and windows can be resized, and windows can be rearranged. [qtile reference](https://docs.qtile.org/en/stable/manual/ref/layouts.html#columns).
   
2. **Bsp**: This layout draws inspiration from bspwm but doesn't attempt to replicate its features. The initial client occupies the entire screen space. When a new client is created, the selected space is divided into two, and the new client occupies one of those subspaces, leaving the old client with the other. The partition can be horizontal or vertical based on the dimensions of the current space: if its width/height ratio exceeds a pre-configured value, the subspaces are created side-by-side; otherwise, they're created on top of each other. The direction of partitioning can be freely toggled. All subspaces can be resized, and clients can be rearranged. All clients are organized at the leaves of a full binary tree. [qtile reference](https://docs.qtile.org/en/stable/manual/ref/layouts.html#bsp).

3. **Max**: Maximized layout. A simple layout that displays only one window at a time, filling the screen_rect. This is suitable for use on laptops and other devices with small screens. Conceptually, the windows are managed as a stack, with commands to switch to the next and previous windows in the stack. [qtile reference](https://docs.qtile.org/en/stable/manual/ref/layouts.html#max).

4. **Floating**: Floating layout, which doesn't manipulate windows but handles the focus order. The latter is configured independently with different options compared to the others. [qtile reference](https://docs.qtile.org/en/stable/manual/ref/layouts.html#floating).

#### [settings.mouse.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/settings/mouse.py)

The `mouse` config file variable defines a set of global mouse actions. It consists of a list of Click and Drag objects that specify actions to be taken when a window is clicked or dragged. [qtile reference](https://docs.qtile.org/en/stable/manual/config/mouse.html).

In this configuration file, mouse button functions are managed as follows:

1. **Left Button click and drag**: Adjust the position of a floating window.
   
2. **Right Button click and drag**: Resize a floating window.
   
3. **Center Button click**: Bring a window to the front.

#### [settings.path.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/settings/path.py)

This path is used by qtile to find the [config.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/config.py) file.

#### [settings.screens.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/settings/screens.py)

Multimonitor support (Not in use on my configuration).

#### [settings.theme.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/settings/theme.py)

Theming for Qtile.

#### [settings.widgets.py](https://github.com/ricardev2023/personal_linux/blob/main/qtile_files/settings/widgets.py)

