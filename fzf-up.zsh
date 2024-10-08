function fzf-down() {
  #setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null

  # fastest way to check if a command exists (50% faster compared to type, hash, which, etc.)
  if (( ! $+commands[fzf] )); then
    echo "[fzf-up] required fzf command not found"
    return 0
  fi

  # select a parent directory
  local selected=($(find . | fzf))
  local ret=$?

  # only change directory when something is selected
  if [ -n "$selected" ]; then
    local directory="$selected"

    # if it's a file, get the directory
    if [ -f "$selected" ]; then
      directory=$(dirname "$directory")
    fi

    # change the directory
    cd "$directory"
  fi

  # guard agains zle not loaded
  zle && { zle reset-prompt; zle -R }

  # respect the exit code of the fzf command execution
  return $ret
}

function fzf-up() {
  #setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null

  # fastest way to check if a command exists (50% faster compared to type, hash, which, etc.)
  if (( ! $+commands[fzf] )); then
    echo "[fzf-up] required fzf command not found"
    return 0
  fi

  # select a parent directory
  local selected=($(_fzf-up::list-parents | fzf))

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
  local parent="$(dirname "$current")"

  # loop until we hit the root directory
  while [[ "$current" != "$parent" ]]; do
    echo "$current"

    current="$parent"
    parent=$(dirname "$current")
  done

  # print root dir name
  echo "$(dirname $current)"
}

function _fzf-up::init() {
  zle     -N    fzf-up
  zle     -N    fzf-down
  bindkey "${FZF_UP_KEY:-^[[}" fzf-up   # alt+[
  bindkey "${FZF_DOWN_KEY:-^[]}" fzf-down # alt+]
}
