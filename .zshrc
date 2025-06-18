export EDITOR=nvim

# unset -f command_not_found_handler # Uncomment to prevent searching for commands not found in package manager
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
alias ls="colorls"
alias la="colorls -al"
alias lt="tree"
alias cat="bat --paging=never"
alias docker_rm='docker rm -f $(docker ps -aq)'
alias ff='fastfetch' 

alias cgp='git config --global user.email "brunolnascimento@gmail.com"'
alias cga='git config --global user.email "bruno.nascimento@agriness.com"'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# Pyenv e virtualenv
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export VIRTUALENVWRAPPER_PYTHON=$HOME/.pyenv/shims/python
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init --path)"
eval "$(pyenv init -)" 
eval "$(pyenv virtualenv-init -)"

# Ruby
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

eval "$(zoxide init zsh)"
