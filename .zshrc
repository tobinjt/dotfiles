# Run for interactive shells.
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list '+' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' prompt 'Corrections (%e):'
zstyle :compinstall filename '/Users/johntobin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000000000
setopt appendhistory autocd nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
