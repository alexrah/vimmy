# ------------------------------------------------------------------------------
#          FILE:  dstkph.zsh-theme
#   DESCRIPTION:  oh-my-zsh theme file.
#        AUTHOR:  Ale Sandro (git@alexrah.otherinbox.com)
#       VERSION:  1.0.0
#    SCREENSHOT:
# ------------------------------------------------------------------------------


# Function to display command prompt: "$" for normal users, red "#" for root user
function prompt_char {
  if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

KUBECTX_PROMPT=false

function kubeprompt(){
  if [[ $KUBECTX_PROMPT == true ]]; then
    KUBECTX_PROMPT=false
  else
    KUBECTX_PROMPT=true
  fi
}

function kube_ctx_prompt() {
  [[ $KUBECTX_PROMPT == true ]] || return
  echo "%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}"
}

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then

    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"

    PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%})
%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}$(python_venv_prompt)%{$reset_color%}$(kube_ctx_prompt)                   ${return_code}
 $(prompt_char) '

    ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]
    then
      RPROMPT='$(git_prompt_status)%{$reset_color%}%{$fg[green]%}[%*]%{$reset_color%}'
    else
      RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'
    fi

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚ "
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹ "
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖ "
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜ "
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═ "
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%} ✭ "
else
    PROMPT='[%n@%m:%~$(git_prompt_info)]
%# '

    ZSH_THEME_GIT_PROMPT_PREFIX=" "
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY="!"
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    # display exitcode on the right when >0
    return_code="%(?..%? ↵ )"

    RPROMPT='${return_code}$(git_prompt_status)'

    ZSH_THEME_GIT_PROMPT_ADDED=" ✚ "
    ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹ "
    ZSH_THEME_GIT_PROMPT_DELETED=" ✖ "
    ZSH_THEME_GIT_PROMPT_RENAMED=" ➜ "
    ZSH_THEME_GIT_PROMPT_UNMERGED=" ═ "
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭ "
fi
