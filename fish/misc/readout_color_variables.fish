#!/usr/bin/env fish

set targets fish_color_normal fish_color_command fish_color_quote fish_color_redirection fish_color_end fish_color_error fish_color_param fish_color_comment fish_color_match fish_color_search_match fish_color_operator fish_color_escape fish_color_cwd fish_color_autosuggestion fish_color_user fish_color_host

for var in $targets
    printf "%-30s %s\n" $var "$$var"
end

