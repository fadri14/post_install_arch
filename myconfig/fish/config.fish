function ssh_agent_init.fish
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

    alias nsh "nvim ~/.config/fish/config.fish"
    alias c "clear"
    alias q "exit"
    alias py "python3"
    alias n "nvim"
    alias vue "nvim -R"
    alias sd "xdg-open ."
    alias ra "ranger"
    alias o "xdg-open 2> /dev/null"
    alias nas "source nas_connection"
    alias mybackup "save_freetube b ; echo '' && backup b"
    alias mirror "wl-mirror -F --fullscreen eDP-1"
    alias findexe "find $(pwd) -type f -executable"
    alias sh "history | grep"
    alias pacdiff "DIFFPROG=meld pacdiff"
    alias gg "git pull"
    alias gs "git status"
    alias gp "source ~/.zshrc ; git_push $(pwd)"
    alias gc "git reset --hard && git clean -fd"
    alias gm "git stash && git pull && git stash apply"
    alias gb "gradle build"
    alias gr "gradle run"
    alias create_snap "sudo snapper -c root create --type single --cleanup-algorithm number --description 'backup_root' ; sudo snapper -c home create --type single --cleanup-algorithm number --description 'backup_home'"

    alias gitco "eval (ssh-agent -c) > /dev/null && ssh-add  ~/.ssh/github && killall ssh-agent"

    bind \eh 'wtype !!\n'

    ssh_agent_init.fish

    starship init fish | source
end
