if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
    fish_config theme choose "catppuccin-mocha"
    alias ls="lsd"
end

set -U __done_min_cmd_duration 30000

set -x SHELL (which fish)

alias gen-nv-cdi='sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml '


