# Run for interactive shells.
# TODO: set umask from .zshenv?
# TODO: where should I source .shell_functions?  I need tmux_attach defined for
# assh to work.
# TODO: cd_helper doesn't work in zsh.

### Completion settings from setup wizard.
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
### Other settings from setup wizard.
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000000000
SAVEHIST=100000000000
setopt appendhistory autocd nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

### Configuration from reading zshoptions(1).
# Configure cd.
setopt auto_pushd pushd_ignore_dups pushd_silent
# Configure completion.
# TODO: figure out how to use bash completion stuff.
# autoload bashcompinit is a start.
# Configure expansion and globbing.
setopt bad_pattern
# Ignore files created by compiling Lisp or Python.
fignore=(.fas .fasl .lib .pyc .pyo)
# Configure history.
# TODO: use zshaddhistory to strip out 'fg'?
setopt extended_history hist_ignore_dups hist_save_no_dups hist_verify
setopt inc_append_history
# Configure job control.
setopt nonotify
# Configure prompting.
# TODO: check out PROMPT_BANG.
# Configure shell emulation.
# TODO: check out POSIX_BUILTINS.

### Configure keybindings; simplified version of ~/.inputrc.
# Mappings for Ctrl-left-arrow and Ctrl-right-arrow for word moving.
# There are many more in ~/.inputrc, but I don't need them now.
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
# On some Apple keyboards shift-3 sends a weird pound sign, remap it to hash.
bindkey -s "£" "#"
# Convert smart quotes to real quotes.
bindkey -s "\xE2\x80\x9C" "\""
bindkey -s "\xE2\x80\x9D" "\""
bindkey -s "\xE2\x80\x98" "'"
bindkey -s "\xE2\x80\x99" "'"
# Convert non-breaking space to space.
bindkey -s "\xC2\xA0" " "
# Minus and em-dash into plain dashes.
bindkey -s "\xE2\x80\x93" "-"
bindkey -s "\xE2\x80\x94" "--"
# Ellipsis...
bindkey -s "\xE2\x80\xA6" "..."
# Bracketed paste escape characters; discard them if they're pasted into the
# shell.
bindkey -s "\e[200~" ""
bindkey -s "\e[201~" ""

### Pull in aliases/functions/settings from shell-neutral files.
# Source prompt_command et al.
# shellcheck disable=SC1090
. "${HOME}/.shell_functions"
# Source shell-neutral environment settings.
# shellcheck disable=SC1090
. "${HOME}/.shell_rc"
# shellcheck disable=SC1090
. "${HOME}/.shell_aliases"

### Set environment variables.
if [ "${USER}" != "johntobin" ]; then
  # Highlight other users in my prompt as a warning.
  # TODO: needs to be tested.
  _prompt_user="%F{red}%n%f"
else
  _prompt_user="%n"
fi
_prompt_nl=$'\n%{\r%}'
PS1="${_prompt_nl}I'm ${_prompt_user} on %m's %l @ %T, %D{%a %Y-%m-%d}, in %4~/"
PS1="${PS1}${_prompt_nl}What is thy bidding? ZSH! "
export PS1

### Misc config.
# Set up prompt_command.
precmd_functions=(prompt_command)

### Local stuff
local_zsh_rc="${HOME}/.zshrc-local"
if [ -f "${local_zsh_rc}" ]; then
  # shellcheck disable=SC1090
  . "${local_zsh_rc}"
fi
