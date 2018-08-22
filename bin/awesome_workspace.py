#!/usr/bin/env python3
#
# forked from github.com/justbuchanan/i3scripts
#
# This script listens for i3 events and updates workspace names to show icons
# for running programs.  It contains icons for a few programs, but more can
# easily be added by adding them to WINDOW_ICONS below.
#
# It also re-numbers workspaces in ascending order with one skipped number
# between monitors (leaving a gap for a new workspace to be created). By
# default, i3 workspace numbers are sticky, so they quickly get out of order.
#
# Dependencies
# * i3ipc       - install with pip
# * fontawesome - install with pip
#
# Installation:
# * Download this script and place it in ~/.config/i3/ (or anywhere you want)
# * Add "exec_always ~/.config/i3/i3-autoname-workspaces.py &" to your i3 config
# * Restart i3: $ i3-msg restart
#
# Configuration:
# The default i3 config's keybindings reference workspaces by name, which is an
# issue when using this script because the "names" are constantaly changing to
# include window icons.  Instead, you'll need to change the keybindings to
# reference workspaces by number.  Change lines like:
#   bindsym $mod+1 workspace 1
# To:
#   bindsym $mod+1 workspace number 1
# same goes for 'move to workspace #'

import i3ipc
import logging
import signal
import sys
import fontawesome as fa

# Add icons here for common programs you use.  The keys are the X window class
# (WM_CLASS) names (lower-cased) and the icons can be any text you want to
# display.
#
# Most of these are character codes for font awesome:
#   http://fortawesome.github.io/Font-Awesome/icons/
#
# If you're not sure what the WM_CLASS is for your application, you can use
# xprop (https://linux.die.net/man/1/xprop). Run `xprop | grep WM_CLASS`
# then click on the application you want to inspect.
WINDOW_ICONS = {
    'alacritty': fa.icons['terminal'],
    'gnome-terminal-server': fa.icons['terminal'],
    'atom': fa.icons['code'],
    'banshee': fa.icons['play'],
    'cura': fa.icons['cube'],
    'darktable': fa.icons['picture-o'],
    'evince': fa.icons['file-pdf-o'],
    'feh': fa.icons['picture-o'],
    'firefox': fa.icons['firefox'],
    'google-chrome': fa.icons['chrome'],
    'gpick': fa.icons['eyedropper'],
    'keybase': fa.icons['key'],
    'kicad': fa.icons['microchip'],
    'kitty': fa.icons['terminal'],
    'libreoffice': fa.icons['file-text-o'],
    'mupdf': fa.icons['file-pdf-o'],
    'postman': fa.icons['space-shuttle'],
    'slack': fa.icons['slack'],
    'spotify': fa.icons['music'],  # could also use the 'spotify' icon
    'steam': fa.icons['steam'],
    'vlc': fa.icons['film'],
    'gedit': fa.icons['file-text-o'],
    'subl': fa.icons['file-text-o'],
    'subl3': fa.icons['file-text-o'],
    'thunar': fa.icons['files-o'],
    'nautilus': fa.icons['files-o'],
    'thunderbird': fa.icons['envelope'],
    'urxvt': fa.icons['terminal'],
    'xfce4-terminal': fa.icons['terminal'],
    'zenity': fa.icons['window-maximize'],
}

# This icon is used for any application not in the list above
DEFAULT_ICON = '*'


# renames all workspaces based on the windows present
def rename_workspaces(i3):
    for workspace in i3.get_tree().workspaces():
        new_icons = [WINDOW_ICONS.get(w.window_instance, DEFAULT_ICON)
                     for w in workspace.leaves()]

        new_name = '  '.join([str(workspace.num) + ':'] + new_icons)
        if workspace.name != new_name:
            i3.command('rename workspace "%s" to "%s"' % (workspace.name,
                                                          new_name))


# Rename workspaces to just numbers and shortnames, removing the icons.
def on_exit(i3):
    for workspace in i3.get_tree().workspaces():
        i3.command('rename workspace "%s" to "%d"' % (workspace.name,
                                                      workspace.num))
    i3.main_quit()
    sys.exit(0)


if __name__ == '__main__':
    i3 = i3ipc.Connection()

    # Exit gracefully when ctrl+c is pressed
    for sig in (signal.SIGINT, signal.SIGTERM):
        signal.signal(sig, lambda signal, frame: on_exit(i3))

    rename_workspaces(i3)

    # Call rename_workspaces() for relevant window events
    def event_handler(i3, e):
        print('trigg')
        rename_workspaces(i3)

    for event_subtype in ('new', 'close', 'move'):
        i3.on('window::' + event_subtype, event_handler)
    i3.main()
