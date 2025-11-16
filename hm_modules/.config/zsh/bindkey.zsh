bindkey -v

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

export KEYTIMEOUT=15
bindkey -M viins 'jk' vi-cmd-mode       
