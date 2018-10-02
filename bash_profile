#!/usr/bin/env bash

brew_prefix=$(brew --prefix)

## Environment Variables

export EDITOR=nvim

export HISTCONTROL=ignoreboth:erasedups
export GIT_DUET_GLOBAL=true
export GIT_DUET_ROTATE_AUTHOR=1
export GIT_DUET_SET_GIT_USER_CONFIG=1

export PATH="${HOME}/go/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"

## Export /usr/local/sbin as fix for openvpn brew link failures.
export PATH="/usr/local/sbin:${PATH}"

export CLICOLOR=1

## BASH Completion

source "${brew_prefix}/etc/bash_completion"

## Aliases

if [ -f ~/.bash_aliases ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.bash_aliases"
fi

## Aliases + Autocompletion
if [[ ! -f $(brew --prefix)/etc/bash_completion.d/kbuectl ]]; then
  ln -fs $(brew --prefix)/etc/bash_completion.d/kubectl $(brew --prefix)/etc/bash_completion.d/kbuectl
fi

if [[ ! -f $(brew --prefix)/etc/bash_completion.d/gti ]]; then
  ln -fs $(brew --prefix)/etc/bash_completion.d/git $(brew --prefix)/etc/bash_completion.d/gti
fi

source <"(k completion bash | sed s/kubectl/k/g)"
## GIT Prompt

if [ -f "${brew_prefix}/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  # shellcheck disable=SC2034
  __GIT_PROMPT_DIR="${brew_prefix}/opt/bash-git-prompt/share"

  # shellcheck source=/dev/null
  source "${brew_prefix}/opt/bash-git-prompt/share/gitprompt.sh"
fi

## AutoJump and FASD

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

eval "$(fasd --init auto)"

## Direnv

eval "$(direnv hook bash)"

## Google Cloud SDK

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

alias vim=nvim
alias vi=nvim

## SSH Autocomplete

_complete_ssh_hosts ()
{
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  comp_ssh_hosts=`cat ~/.ssh/config | \
    grep "^Host " | \
    awk '{print $2}'`
  COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur) )
  return 0
}

complete -F _complete_ssh_hosts ssh
complete -F _complete_ssh_hosts sshuttle

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
