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

# Configure cd.
setopt auto_pushd pushd_ignore_dups pushd_silent
# Configure expansion and globbing.
setopt bad_pattern
# Configure history.
setopt extended_history hist_ignore_dups hist_save_no_dups hist_verify
# Configure job control.
setopt nonotify
# Configure prompting.
# TODO: check out PROMPT_BANG.
# Configure shell emulation.
# TODO: check out POSIX_BUILTINS.
