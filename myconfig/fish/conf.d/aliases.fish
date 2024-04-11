alias nsh "nvim ~/.config/fish/config.fish"
alias c "clear"
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
alias gp 'source ~/.config/fish/config.fish ; bash -e git_push $(pwd)'
alias gc "git reset --hard && git clean -fd"
alias gm "git stash && git pull && git stash apply"
alias gb "gradle build"
alias gr "gradle run"
alias create_snap "sudo snapper -c root create --type single --cleanup-algorithm number --description 'backup_root' ; sudo snapper -c home create --type single --cleanup-algorithm number --description 'backup_home'"
alias gitco "ssh_agent_init && echo 'yes' > /home/adrien/.ssh/state_connect"
