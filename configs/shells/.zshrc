# The following lines were added by compinstall
zstyle :compinstall filename '/home/arfs6/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd notify
bindkey -v
# End of lines configured by zsh-newuser-install
source ~/.sh_aliases
source ~/.sh_env

echo "Welcome $HOST"

if [[ $SHLVL == 1 ]]; then
	cd
fi

#
# Setup ohmy posh
eval "$(oh-my-posh init zsh --config ~/.poshthemes/arfs6.omp.json)"
# linux brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"                                                                  
# Enable zoxide
eval "$(zoxide init zsh)"
