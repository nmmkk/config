# Completions for todo.sh

# This file defines the completions as listed in 'todo.sh shorthelp'.
#-----
#   Usage: todo.sh [-fhpantvV] [-d todo_config] action [task_number] [task_description]
#
#   Actions:
#     add|a "THING I NEED TO DO +project @context"
#     addm "THINGS I NEED TO DO
#           MORE THINGS I NEED TO DO"
#     addto DEST "TEXT TO ADD"
#     append|app ITEM# "TEXT TO APPEND"
#     archive
#     command [ACTIONS]
#     deduplicate
#     del|rm ITEM# [TERM]
#     depri|dp ITEM#[, ITEM#, ITEM#, ...]
#     do ITEM#[, ITEM#, ITEM#, ...]
#     help [ACTION...]
#     list|ls [TERM...]
#     listall|lsa [TERM...]
#     listaddons
#     listcon|lsc [TERM...]
#     listfile|lf [SRC [TERM...]]
#     listpri|lsp [PRIORITIES] [TERM...]
#     listproj|lsprj [TERM...]
#     move|mv ITEM# DEST [SRC]
#     prepend|prep ITEM# "TEXT TO PREPEND"
#     pri|p ITEM# PRIORITY
#     replace ITEM# "UPDATED TODO"
#     report
#     shorthelp
#
#   Actions can be added and overridden using scripts in the actions
#   directory.
#
#   See "help" for more details.


set -l progname todo.sh

complete -c $progname -e
complete -c $progname -f

set -l todo_common -c $progname -n '__fish_use_subcommand'

complete $todo_common -a 'add' --description='THINGS I NEED TO DO +project @context'
complete $todo_common -a 'addm' --description='THINGS I NEED TO DO (accept multiple lines)' -x
complete $todo_common -a 'addto' --description='DEST "TEST TO ADD"' -x
complete $todo_common -a 'archive' --description='' -x
complete $todo_common -a 'command' --description='[ACTIONS]' -f
complete $todo_common -a 'deduplicate' --description='' -x
complete $todo_common -a 'del' --description='ITEM# [TERM]' -x
complete $todo_common -a 'rm' --description='ITEM# [TERM]' -x
complete $todo_common -a 'depri' --description='ITEM#[, ITEM#, ITEM#, ...]' -x
# complete $todo_common -a 'dp' --description='ITEM#[, ITEM#, ITEM#, ...]' -x
complete $todo_common -a 'do' --description='ITEM#[, ITEM#, ITEM#, ...]' -x
complete $todo_common -a 'help' --description='[ACTION...]' -x
complete $todo_common -a 'list' --description='[TERM...]' -x
# complete $todo_common -a 'ls' --description='[TERM...]' -x
complete $todo_common -a 'listall' --description='[TERM...]' -x
# complete $todo_common -a 'lsa' --description='[TERM...]' -x
complete $todo_common -a 'listaddons' --description='' -x
complete $todo_common -a 'listcon' --description='[TERM...]' -x
# complete $todo_common -a 'lsc' --description='[TERM...]' -x
complete $todo_common -a 'listfile' --description='[SRC [TERM...]]' -x
# complete $todo_common -a 'lsp' --description='[SRC [TERM...]]' -x
complete $todo_common -a 'listproj' --description='[TERM...]' -x
# complete $todo_common -a 'lsprj' --description='[TERM...]' -x
complete $todo_common -a 'move' --description='ITEM# DEST [SRC]' -x
# complete $todo_common -a 'mv' --description='ITEM# DEST [SRC]' -x
complete $todo_common -a 'prepend' --description='ITEM# "TEXT TO PREPEND' -x
# complete $todo_common -a 'prep' --description='ITEM# "TEXT TO PREPEND' -x
complete $todo_common -a 'pri' --description='ITEM# PRIORITY' -x
# complete $todo_common -a 'p' --description='ITEM# PRIORITY' -x
complete $todo_common -a 'replace' --description='ITEM# "UPDATED TODO' -x
complete $todo_common -a 'report' --description='' -x
complete $todo_common -a 'shorthelp' --description='' -x

