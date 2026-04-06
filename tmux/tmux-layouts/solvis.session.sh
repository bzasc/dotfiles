# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/solvis"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "solvis"; then

  window_root "~/dev"
  new_window "code"
  split_v 5
  tmux select-pane -U
  split_h 5
  tmux select-pane -L

  window_root "~/annotations/bzasc_brain/"
  new_window "annotation"

  select_window 1
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
