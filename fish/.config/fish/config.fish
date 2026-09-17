source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if not set -q SSH_AUTH_SOCK
    #start the ssh agenttest
    eval (ssh-agent -c) >/dev/null
    #add the github ssh key
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
end

if status is-interactive # Commands to run in interactive sessions can go here

    zoxide init fish --cmd z | source
    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias nivm nvim
    alias ls 'eza --icons=auto'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    alias ssh "kitten ssh"
    alias info='info --vi-keys'

    fish_vi_key_bindings
    # fish_vi_key_bindings [--no-erase] [INIT_MODE]

    function esp
        git config --global --get-all safe.directory | grep -q '^/opt/esp-idf$'
        or git config --global --add safe.directory /opt/esp-idf

        source /opt/esp-idf/export.fish

        function idf
            idf.py $argv
        end

    end

    function multicd
        echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end
    abbr --add dotdot --regex '^\.\.+$' --function multicd
end
