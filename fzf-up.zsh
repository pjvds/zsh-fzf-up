function _fzf-up::widget() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null

  local selected 
  selected=($(_fzf-up::list-parents | fzf))

  local ret=$?
  # only change directory when something is selected
  if [ -n "$selected" ]; then
    cd "$selected"
  fi

  # guard agains zle not loaded
  zle && { zle reset-prompt; zle -R }

  # respect the exit code of the fzf command execution
  return $ret
}

function _fzf-up::list-parents() {
  # get the current directory
  local current="$(pwd)"

  # loop until we hit the root directory
  while [[ "$current" != "/" ]]; do
    echo "$current"

    current=$(dirname "$current")
  done
}

function _fzf-up::init() {
  zle     -N   _fzf-up::widget
  bindkey '^U' _fzf-up::widget
}
