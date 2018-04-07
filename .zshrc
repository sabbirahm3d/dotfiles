# ZSH config file

# Path to your oh-my-zsh installation.
export ZSH=/home/sabbir/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME="bullet-train"

# Hyphen-insensitive completion. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for
# completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
# For a full list of active aliases, run `alias`.

# adds options to change directory to dirname of file
cd() {
  [[ ! -e $argv[-1] ]] || [[ -d $argv[-1] ]] || argv[-1]=${argv[-1]%/*}
  builtin cd "$@"
}

highlight () { grep -iE "$1|$" "${@:2}" ; }
search () { grep -irnwc ${@:2} -e $1 | grep -v ":0$" ; }
pdf () { evince "$@" &> /dev/null & disown; }
mvthere () { cd "$(cat ~/."$(basename $(echo $SHELL))"_history | grep "mv" | tail -n2 | head -n1 | grep -oE '[^ ]+$')"; }

alias highlight="highlight"
alias search="search"
alias pdf="pdf"
alias mvthere="mvthere"
alias sysupdate="sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean"
alias bump="~/helper-scripts/bump/bump.sh"
alias pyup="~/helper-scripts/pyup/pyup.sh"
alias prettyjson="python -m json.tool"

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Completers for custom aliases
zstyle ':completion:*:*:pdf*:*' file-patterns '*.pdf *(-/)'
zstyle ':completion:*:*:prettyjson*:*' file-patterns '*.json *(-/)'