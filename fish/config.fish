# config.fish

#
# Functions
#

# [bashで言うところの!$はfishではどうすればよいか - Qiita](http://qiita.com/ymko/items/d7c5c4d0cc6174d5fc86)
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end




#
# Define key bindings
#
function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar

    # [fish shell を使いたい人生だった ｜ Developers.IO](http://dev.classmethod.jp/etc/fish-shell-life/)
    bind \cr 'peco_select_history (commandline -b)'
end






#
# Aliases/Baliases
#
# For balias, make sure balias plugin is installed:
#   `fisher oh-my-fish/plugin-balias`
balias g git

