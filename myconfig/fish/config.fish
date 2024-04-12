if status is-interactive
    set -g fish_greeting ''

    export EDITOR=/usr/bin/nvim
    export PATH="$HOME/.config/myscripts/:$PATH"
    export PATH="$PATH:$HOME/.cargo/bin/"

    bind \eh 'wtype !!\n'
    bind \e\r 'wtype -M ctrl -k f -m ctrl ; wtype \n'
    bind \er 'wtype -M alt -k Left -m alt'
    bind \en 'wtype -M alt -k Right -m alt'
    bind \ew backward-kill-path-component

    if test $(cat ~/.ssh/state_connect) = "yes"
        ssh_agent_init
    end

    starship init fish | source
end
