function devsession --description 'Create or attach a tmux coding cockpit'
    set -l session_name
    if test (count $argv) -ge 1
        set session_name $argv[1]
    else
        set session_name (basename "$PWD")
    end

    if set -q TMUX
        printf '%s\n' 'Already in a tmux session. Detach first or run devsession from outside tmux.'
        return 1
    end

    if tmux has-session -t "$session_name" 2>/dev/null
        tmux attach-session -t "$session_name"
        return $status
    end

    set -l workspace $PWD
    set -l notes_root
    if set -q OBSIDIAN_VAULT
        set notes_root $OBSIDIAN_VAULT
    else
        set notes_root "$HOME/annotations/bzasc_brain"
    end

    set -l cols (tput cols)
    set -l lines (tput lines)

    tmux new-session -d -s "$session_name" -n code -c "$workspace" -x "$cols" -y "$lines"

    set -l main_pane (tmux display-message -p -t "$session_name":code '#{pane_id}')
    set -l right_pane (tmux split-window -h -P -F '#{pane_id}' -t "$main_pane" -c "$workspace" -l 30%)
    set -l bottom_pane (tmux split-window -v -P -F '#{pane_id}' -t "$main_pane" -c "$workspace" -l 20%)

    #tmux send-keys -t "$main_pane" 'nvim' C-m
    #tmux send-keys -t "$right_pane" 'claude' C-m

    tmux new-window -t "$session_name": -n annotation -c "$notes_root"
    tmux select-window -t "$session_name":code
    tmux select-pane -t "$main_pane"
    tmux attach-session -t "$session_name"
end
