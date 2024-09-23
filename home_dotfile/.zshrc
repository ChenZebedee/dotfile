export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions autojump fzf)

source /etc/profile

source $ZSH/oh-my-zsh.sh

#eval "$(~/miniconda3/bin/conda shell.zsh hook)" 

#🔽🔽🔽
# alias
#alias r="ranger"
#alias fd="fdfind"
alias setProxy="export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890;"
# 依次检测bat/cat是否存在，存在替换成对应的，推荐使用bat，并且使用--style=plain更朴素一点
# command -v ccat &>/dev/null && alias cat="ccat"
alias cat='bash -c '\''my_cat=""; if command -v bat >/dev/null 2>&1; then my_cat="bat --style=plain"; else if command -v ccat >/dev/null 2>&1; then my_cat="ccat"; else my_cat="cat"; fi; fi; if [ -z $@ ]; then $my_cat .; else $my_cat "$@"; fi'\'' bash'
# 依次检测lvim/nvim是否存在，存在替换成对应的
alias v='bash -c '\''my_vim=""; if command -v lvim >/dev/null 2>&1; then my_vim="lvim"; else if command -v nvim >/dev/null 2>&1; then my_vim="nvim"; else my_vim="vim"; fi; fi; if [ $# -gt 0 ]; then $my_vim "$@"; else $my_vim .; fi'\'' bash'
alias vim='bash -c '\''my_vim=""; if command -v lvim >/dev/null 2>&1; then my_vim="lvim"; else if command -v nvim >/dev/null 2>&1; then my_vim="nvim"; else my_vim="vim"; fi; fi; if [ $# -gt 0 ]; then $my_vim "$@"; else $my_vim .; fi'\'' bash'
alias cf="cd \$(fd --type d --hidden | fzf)"
alias cfh="cd ~ && cd \$(fd --type d --hidden | fzf)" # search from home
#🔼🔼🔼

export EDITOR=/usr/local/bin/nvim

#🔽🔽🔽
# fzf
local fzf_ignore=".wine,.git,.idea,.vscode,node_modules,build"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude={${fzf_ignore}} "
export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --preview 'echo {} | ~/.config/fzf/fzf_preview.py' --preview-window=down --border \
  --bind ctrl-d:page-down,ctrl-u:page-up \
  "
_fzf_compgen_path() {
  fd --hidden --follow --exclude={${fzf_ignore}}
}
_fzf_compgen_dir() {
  fd --type d --hidden --exclude={${fzf_ignore}}
}
#🔼🔼🔼

# autojump
#🔽🔽🔽
j() {
  local preview_cmd="ls {2..}"
  if command -v exa &> /dev/null; then
    preview_cmd="exa -l {2}"
  fi

  if [[ $# -eq 0 ]]; then
    cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 80% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -d$'\t' -f2- | sed 's/^\s*//')"
  else
    cd $(autojump $@)
  fi
}
#🔼🔼🔼

#🔽🔽🔽
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#🔼🔼🔼


export EDITOR=/usr/local/bin/nvim


#🔽🔽🔽
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#🔼🔼🔼

#🔽🔽🔽
# gvm install
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
#🔼🔼🔼

source ~/.config/neofetch/lolcat_neofetch.sh


#🔽🔽🔽
# Created by `pipx` on 2024-09-02 06:36:06
export PATH="$PATH:/root/.local/bin"
#🔼🔼🔼

#🔽🔽🔽
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/root/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/root/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/root/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/root/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#🔼🔼🔼

[[ ! -f "~/.localzsh" ]] && cp ~/.localzsh_base ~/.localzsh

source ~/.localzsh
