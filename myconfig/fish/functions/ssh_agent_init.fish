function ssh_agent_init
    set ssh_agent_var $(keychain --eval --quiet -Q github)
    set ssh_agent_pid $(pgrep ssh-agent)
    set ssh_agent_name $(echo $ssh_agent_var | cut -d "/" -f3)
    
    set SSH_AUTH_SOCK /tmp/$ssh_agent_name/agent.$(math $ssh_agent_pid - 1)
    export SSH_AUTH_SOCK
    set SSH_AGENT_PID $ssh_agent_pid
    export SSH_AGENT_PID
end

