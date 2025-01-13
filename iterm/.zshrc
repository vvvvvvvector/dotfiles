# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

HISTSIZE=100000
SAVEHIST=$HISTSIZE

# -----------------aliases-----------------

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias tc=clear
alias pn=pnpm
alias px=pnpm dlx
alias lg=lazygit

# -----------------aliases-----------------

# -----------------nvm-----------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f "/Users/vvvvvec1or/.ghcup/env" ] && source "/Users/vvvvvec1or/.ghcup/env" # ghcup-env
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# -----------------nvm-----------------

# -----------------pnpm-----------------

export PNPM_HOME="/Users/vvvvvec1or/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# -----------------pnpm-----------------

# -----------------fzf-----------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd -H -E .git --type f'
export FZF_DEFAULT_OPTS='--height 100% --preview-window=down,70%'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#ffffff,bg:-1,bg+:#262626
  --color=hl:#3b82f6,hl+:#60a5fa,info:#71717a,marker:#10b981
  --color=prompt:#c084fc,spinner:#c084fc,pointer:#c084fc,header:#10b981
  --color=border:#71717a,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧: "
  --marker="$" --pointer="|" --separator="~" --scrollbar="|"'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
  --preview 'bat --style numbers,changes --color=always --line-range :500 {}'
  --bind 'ctrl-/:change-preview-window(hidden|)'"

# -----------------fzf-----------------

# -----------------fzf-git-----------------

# [ -f ~/.fzf-git.sh ] && source ~/.fzf-git.sh
#
# _fzf_git_fzf() {
#   fzf-tmux -- \
#     --layout=reverse --multi --height=100% --border \
#     --border-label-pos=2 \
#     --color='header:italic:underline,label:blue' \
#     --preview-window='bottom,70%,border-top' \
#     --bind='ctrl-/:change-preview-window(right,65%,border-left|hidden|)' "$@"
# }
#
# _fzf_git_remotes() {
#   _fzf_git_check || return
#   git remote -v | awk '{print $1 "\t" $2}' | uniq |
#   _fzf_git_fzf --tac \
#     --border-label 'Remotes' \
#     --header $'CTRL-O (open in browser)\n\n' \
#     --bind "ctrl-o:execute-silent:bash $__fzf_git remote {1}" \
#     --preview "git log --oneline --graph --date=short --color=$(__fzf_git_color .) --pretty='format:%C(auto)%cd %h%d %s' '{1}/$(git rev-parse --abbrev-ref HEAD)' --" "$@" |
#   cut -d$'\t' -f1
# }
#
# _fzf_git_branches() {
#   _fzf_git_check || return
#   bash "$__fzf_git" branches |
#   _fzf_git_fzf --ansi \
#     --border-label 'Branches' \
#     --header-lines 2 \
#     --tiebreak begin \
#     --color hl:underline,hl+:underline \
#     --no-hscroll \
#     --bind "ctrl-o:execute-silent:bash $__fzf_git branch {}" \
#     --bind "alt-a:change-border-label(All branches)+reload:bash \"$__fzf_git\" all-branches" \
#     --preview "git log --oneline --graph --date=short --color=$(__fzf_git_color .) --pretty='format:%C(auto)%cd %h%d %s' \$(sed s/^..// <<< {} | cut -d' ' -f1) --" "$@" |
#   sed 's/^..//' | cut -d' ' -f1
# }
#
# _fzf_git_hashes() {
#   _fzf_git_check || return
#   bash "$__fzf_git" hashes |
#   _fzf_git_fzf --ansi --no-sort --bind 'ctrl-s:toggle-sort' \
#     --border-label 'Hashes' \
#     --header-lines 3 \
#     --bind "ctrl-o:execute-silent:bash $__fzf_git commit {}" \
#     --bind "ctrl-d:execute:grep -o '[a-f0-9]\{7,\}' <<< {} | head -n 1 | xargs git diff --color=$(__fzf_git_color) > /dev/tty" \
#     --bind "alt-a:change-border-label(All hashes)+reload:bash \"$__fzf_git\" all-hashes" \
#     --color hl:underline,hl+:underline \
#     --preview "grep -o '[a-f0-9]\{7,\}' <<< {} | head -n 1 | xargs git show --color=$(__fzf_git_color .) | $(__fzf_git_pager)" "$@" |
#   awk 'match($0, /[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]*/) { print substr($0, RSTART, RLENGTH) }'
# }

# -----------------fzf-git-----------------

# -----------------bat-----------------

export BAT_THEME="Visual Studio Dark+"

# -----------------bat-----------------

# -----------------thefuck-----------------

eval $(thefuck --alias)

# -----------------thefuck-----------------


# -----------------zoxide-----------------

eval "$(zoxide init zsh)"

# -----------------zoxide-----------------

. "$HOME/.local/bin/env"

# -----------------vi-mode-----------------

# export KEYTIMEOUT=1

# VI_MODE_SET_CURSOR=true

# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

# Start in the normal mode
# autoload -Uz add-zle-hook-widget
# add-zle-hook-widget line-init vi-cmd-mode

# -----------------vi-mode-----------------

# -----------------zsh-vi-mode-----------------

ZVM_VI_EDITOR=nvim

ZVM_VI_HIGHLIGHT_FOREGROUND=#fafafa
ZVM_VI_HIGHLIGHT_BACKGROUND=#4f46e5
ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold

# to not use bck-i-search on insert mode
function zvm_after_init() {
  zvm_bindkey viins "^R" fzf-history-widget
  zvm_bindkey viins "^I" fzf-completion
}

# -----------------zsh-vi-mode-----------------

# -----------------zsh-autosuggestions-----------------

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#818cf8,bold,underline"

# -----------------zsh-autosuggestions-----------------
