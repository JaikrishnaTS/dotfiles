#!/bin/bash
set -e

# List all sinks in a dmenu and get user input
sel_op=( $(pactl list short sinks | awk '{print $1" | "$2}' | 
    dmenu -i -p "Select an audio sink:") )

sink_id=${sel_op[0]};

# switching default
pactl set-default-sink ${sink_id}

# switching applications
pactl list short sink-inputs | awk '{print $1}' |
  xargs -r -I{} pactl move-sink-input {} ${sink_id}
