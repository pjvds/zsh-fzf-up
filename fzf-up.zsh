function _fzf-up::widget() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null

  # fastest way to check if a command exists (50% faster compared to type, hash, which, etc.)
  if (( ! $+commands[fzf] )); then
    echo "[fzf-up] required fzf command not found"
    return 0
  fi

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
