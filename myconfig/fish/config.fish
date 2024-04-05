if status is-interactive
    # fisher install b4b4r07/enhancd
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

    starship init fish | source
end
