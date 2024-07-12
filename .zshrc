if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=( 
    git 
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    poetry
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
alias ls="colorls"
alias la="colorls -al"
alias la="tree"
alias cat="bat --paging=never"
alias docker_rm="docker rm -f $(docker ps -aq)"

alias cgp='git config --global user.email "brunolnascimento@gmail.com"'
alias cga='git config --global user.email "bruno.nascimento@agriness.com"'

alias ff='fastfetch'
alias neofetch="neofetch --ascii_colors 2 7 --colors 2 7 2 2 7 7 2"

export EDITOR=nvim

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export VIRTUALENVWRAPPER_PYTHON=$HOME/.pyenv/shims/python
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh 


command -v pyenv >/dev/null || export PATH="$HOME/.local/bin:$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Ruby
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# NPM
export PATH=~/.npm-global/bin:$PATH

eval "$(zoxide init zsh)"
