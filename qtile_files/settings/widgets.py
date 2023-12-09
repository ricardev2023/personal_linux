# QTILE Widgets Settings
# by strelock

from libqtile import widget
from .theme import colors
from subprocess import check_output
from os import path

# Get the icons at:
# https://www.nerdfonts.com/cheat-sheet
# You need a Nerd Font installed.

# Initialize a class for all the commands used in widgets.
class Commands:
    def my_ip(self):
        '''
        A function that shows my private ip address.
        '''
        interface = "ens33" # Change this
        try:
            ip = check_output(['ifconfig', '-a', interface]).decode("utf-8").replace("\n", "")
            position = ip.find('inet ')
            return str(ip[(position + 5):(ip.find(" ", position + 5))]) + " "
        except:
            return ("Not connected ")

    def vpn_ip(self):
        '''
        A function that shows my VPN ip address.
        '''
        interface = "tun0" # Change this
        try:
            ip = check_output(['ifconfig', '-a', interface]).decode("utf-8").replace("\n", "")
            position = ip.find('inet ')
            return str(ip[(position + 5):(ip.find(" ", position + 5))]) + " "
        except:
            return ("VPN Not connected ")

    def target(self):
        '''
        A function that shows the targets name and IP.
        All this information is saved in a txt file.
        '''
        try:
            target_path = path.join(path.expanduser('~'), "Documents", "htb", "target", "target.txt")
            return check_output(["cat", target_path]).decode("utf-8").replace("\n", "") + "  "
        except:
            return "Target Not Set  "

commands = Commands()

def base(fg='text', bg='dark'): 
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }

def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)

def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )

def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="", # Icon: nf-oct-triangle_left
        fontsize=49,
        padding=-9
    )

def workspaces(): 
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='UbuntuMono Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]

def ip_widget(fg="text", bg="dark"):
    return widget.GenPollText(
        **base(fg, bg),
        func=commands.my_ip,
        update_interval=60
    )

def vpn_widget(fg="text", bg="dark"):
    return widget.GenPollText(
        **base(fg, bg),
        func=commands.vpn_ip,
        update_interval=60
    )

def target_widget(fg="text", bg="dark"):
    return widget.GenPollText(
        **base(fg, bg),
        func=commands.target,
        update_intervale=60

    )

primary_widgets = [

    *workspaces(),
    
    powerline('color1', 'dark'),
    
    icon(bg="color1", fontsize=23, text='什'), # nf-mdi-target

    target_widget(bg='color1'),

    powerline('color2', 'color1'),

    icon(bg="color2", fontsize=23, text=' '), # nf-mdi-cube_outline

    vpn_widget(bg='color2'),

    powerline('color1', 'color2'),

    icon(bg="color1", fontsize=23, text=' '), # nf-mdi-access_point_network

    ip_widget(bg='color1'),

    powerline('color2', 'color1'),
    
    widget.CurrentLayoutIcon(**base(bg='color2'), scale=0.65),

    widget.CurrentLayout(**base(bg='color2'), padding=5),

    powerline('color1', 'color2'),

    icon(bg="color1", fontsize=23, text=' '), # Icon: nf-mdi-calendar_clock

    widget.Clock(**base(bg='color1'), format='%d/%m/%Y - %H:%M '),

    powerline('dark', 'color1'),

    widget.Systray(background=colors['dark'], padding=5),
]

secondary_widgets = [
    *workspaces(),

    separator(),

    powerline('color1', 'dark'),

    widget.CurrentLayoutIcon(**base(bg='color1'), scale=0.65),

    widget.CurrentLayout(**base(bg='color1'), padding=5),

    powerline('color2', 'color1'),

    widget.Clock(**base(bg='color2'), format='%d/%m/%Y - %H:%M '),

    powerline('dark', 'color2'),
]

widget_defaults = {
    'font': 'UbuntuMono Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
