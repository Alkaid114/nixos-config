if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
    starship init fish | source
    # navi widget fish | source
    set -x NAVI_FZF_OVERRIDES "--height 20% --layout=reverse --border"
    # 重新自定义绑定
    function _navi_get_command
        set -l current_query (commandline -b)
        
        set -l result (navi --query "$current_query" --print)
        
        if test -n "$result"
            commandline -r "$result"
        end
        
        commandline -f repaint
    end

    bind \cg _navi_get_command
end

set -U __done_min_cmd_duration 30000

set -x SHELL (which fish)

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
#alias vim='nvim'
alias ls="lsd"
alias gen-nv-cdi='sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml '
function fnm
    command fnm env --use-on-cd --shell fish | source
    functions -e fnm
    command fnm $argv
end

# fish_config theme choose "Catppuccin Mocha"

if test "$TERM_PROGRAM" = "WezTerm"
    # fastfetch
end


