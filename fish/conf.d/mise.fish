set -gx PATH /Users/bzasc/.config/tmux/tmuxifier/libexec /opt/homebrew/opt/mise/bin /Users/bzasc/.local/bin /Users/bzasc/.cargo/bin /Users/bzasc/.config/tmux/tmuxifier/bin /usr/local/bin /System/Cryptexes/App/usr/bin /usr/bin /bin /usr/sbin /sbin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin /opt/pmk/env/global/bin /Library/Apple/usr/bin /opt/homebrew/bin /Applications/Ghostty.app/Contents/MacOS
functions --erase __mise_env_eval
functions --erase __mise_env_eval_2
functions --erase __mise_cd_hook
functions --erase mise
set -e MISE_SHELL
set -e __MISE_DIFF
set -e __MISE_SESSION
set -gx MISE_SHELL fish
if not set -q __MISE_ORIG_PATH
    set -gx __MISE_ORIG_PATH $PATH
end

function mise
  if test (count $argv) -eq 0
    command /opt/homebrew/opt/mise/bin/mise
    return
  end

  set command $argv[1]
  set -e argv[1]

  if contains -- --help $argv
    command /opt/homebrew/opt/mise/bin/mise "$command" $argv
    return $status
  end

  switch "$command"
  case deactivate shell sh
    # if help is requested, don't eval
    if contains -- -h $argv
      command /opt/homebrew/opt/mise/bin/mise "$command" $argv
    else if contains -- --help $argv
      command /opt/homebrew/opt/mise/bin/mise "$command" $argv
    else
      source (command /opt/homebrew/opt/mise/bin/mise "$command" $argv |psub)
    end
  case '*'
    command /opt/homebrew/opt/mise/bin/mise "$command" $argv
  end
end

function __mise_env_eval --on-event fish_prompt --description 'Update mise environment when changing directories';
    /opt/homebrew/opt/mise/bin/mise hook-env -s fish | source;

    if test "$mise_fish_mode" != "disable_arrow";
        function __mise_cd_hook --on-variable PWD --description 'Update mise environment when changing directories';
            if test "$mise_fish_mode" = "eval_after_arrow";
                set -g __mise_env_again 0;
            else;
                /opt/homebrew/opt/mise/bin/mise hook-env -s fish | source;
            end;
        end;
    end;
end;

function __mise_env_eval_2 --on-event fish_preexec --description 'Update mise environment when changing directories';
    if set -q __mise_env_again;
        set -e __mise_env_again;
        /opt/homebrew/opt/mise/bin/mise hook-env -s fish | source;
        echo;
    end;

    functions --erase __mise_cd_hook;
end;

__mise_env_eval
if functions -q fish_command_not_found; and not functions -q __mise_fish_command_not_found
    functions -e __mise_fish_command_not_found
    functions -c fish_command_not_found __mise_fish_command_not_found
end

function fish_command_not_found
    if string match -qrv -- '^(?:mise$|mise-)' $argv[1] &&
        /opt/homebrew/opt/mise/bin/mise hook-not-found -s fish -- $argv[1]
        /opt/homebrew/opt/mise/bin/mise hook-env -s fish | source
    else if functions -q __mise_fish_command_not_found
        __mise_fish_command_not_found $argv
    else
        __fish_default_command_not_found_handler $argv
    end
end
