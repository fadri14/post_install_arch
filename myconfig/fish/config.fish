function ssh_agent_init
    set ssh_agent_var $(keychain --eval --quiet -Q id_ed25519)
    set ssh_agent_pid $(pgrep ssh-agent)
    set ssh_agent_name $(echo $ssh_agent_var | cut -d "/" -f3)
    
    set SSH_AUTH_SOCK /tmp/$ssh_agent_name/agent.$(math $ssh_agent_pid - 1)
    export SSH_AUTH_SOCK
    set SSH_AGENT_PID $ssh_agent_pid
    export SSH_AGENT_PID
end

if status is-interactive
    set -g fish_greeting ''

    export EDITOR=/usr/bin/nvim
    export PATH="$HOME/.config/myscripts/:$PATH"
    export PATH="$PATH:$HOME/.cargo/bin/"

    bind \eh 'wtype !!\n'

    if test $(cat ~/.ssh/state_connect) = "yes"
        ssh_agent_init
    end

    starship init fish | source
end
