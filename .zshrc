# Run for interactive shells.
# TODO: where should I source .shell_functions?  I need tmux_attach defined for
# assh to work.

### Completion settings from setup wizard.
# Note: added -u to compinit because my user owns homebrew but other users need
# to use it, and compinit complains about security without -u.  I thought about
# the security aspect: if someone can put a malicious completion script on my
# machines, they can do a whole lot worse, so I don't believe it's a problem.
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list '+' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' prompt 'Corrections (%e):'
zstyle :compinstall filename '/Users/johntobin/.zshrc'

autoload -Uz compinit
compinit -u
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
# If I want to use bash completion stuff start with 'autoload bashcompinit'.
# Configure expansion and globbing.
setopt bad_pattern
# Ignore files created by compiling Lisp or Python.
fignore=(.fas .fasl .lib .pyc .pyo)
# Configure history.
setopt extended_history hist_ignore_dups hist_save_no_dups hist_verify
setopt inc_append_history
# Configure job control.
setopt nonotify

### Configure keybindings; simplified version of ~/.inputrc.
# This makes space expand stuff so you can see what !$, !:0 etc. are.
bindkey " " magic-space
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
. "${HOME}/.shell_functions"
. "${HOME}/.shell_rc"
. "${HOME}/.shell_aliases"

### Set environment variables.
if [[ "${USER}" != "johntobin" ]]; then
  # Highlight other users in my prompt as a warning.
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
# Do not add fg to history.  zsh doesn't have a way to completely remove it from
# history, it will be there immediately afterwards but will disappear after
# running any other command.
function zshaddhistory() {
  case "$1" in
    # The parameter appears to be exactly what was typed, including the newline.
    $'fg\n')
      return 1
      ;;
  esac
  return 0
}

### Local stuff
local_zsh_rc="${HOME}/.zshrc-local"
if [[ -f "${local_zsh_rc}" ]]; then
  . "${local_zsh_rc}"
fi
