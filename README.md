# NAME

fzf-up - change to a parent directory in style

# DESCRIPTION

fzf-up is a faster way to navigate your parent directory tree. It works by listing all parent directories and feeding it to fzf. This allows you to pick the parent directory you want to change to with fzf.

# USAGE

By default fzf-up binds to CTRL+[ to change directory to a parent location and CTRL+] for a child location.

# INSTALLATION

## antigen

```
antigen bundle "pjvds/zsh-fzf-up"
```

## zinit

```
zinit ice silent depth=1 wait"1"
zinit light "pjvds/zsh-fzf-up"
```

## zplug

```
zplug "pjvds/zsh-fzf-up"
```

## zgen

```
zgen load "pjvds/zsh-fzf-up"
```

## Oh My Zsh

Clone `zsh-fzf-up` into your custom plugins directory

```
git clone https://github.com/pjvds/zsh-fzf-up \
 $ZSH/custom/plugins/zsh-fzf-up
```

Then load as a plugin in your `.zshrc`

```
plugins+=(zsh-fzf-up)
```
