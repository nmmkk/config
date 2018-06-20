" Dein configuration

if &compatible
 set nocompatible
endif

let s:dein_cache_dir = g:cache_home . '/dein'

if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

    " Auto Download
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif

    " Load dein.vim as a plugin
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

" dein.vim settings
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1
let g:dein#install_log_filename = '~/log/dein.log'

if dein#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)

    call dein#add(s:dein_cache_dir)
    call dein#add('Shougo/deoplete.nvim')
    let s:toml_dir = g:config_home . '/dein'

    if !has('nvim')
        call dein#load_toml(s:toml_dir . '/vim.toml', {'lazy': 0})
    endif
    call dein#load_toml(s:toml_dir . '/plugins.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})
    if has('nvim')
        call dein#load_toml(s:toml_dir . '/neovim.toml', {'lazy': 0})
    endif

    call dein#end()
    call dein#save_state()
endif

" Necessary lines for deoplete to be loaded and work properly "{{{1

" Execute commands listed in "hook_source" in toml file
" The help document 'dein-options-hook_source' explains this as below:
"   Note: non lazy plugins' dein-options-hook_source cannot be
"   called.  You must call it by dein#call_hook() if needed.
call dein#call_hook('source')

syntax enable
filetype plugin indent on
"}}}1

" if !has('vim_starting') && dein#check_install()
if dein#check_install()
    call dein#install()
endif
