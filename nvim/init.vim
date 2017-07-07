" Ref: http://qiita.com/Ress/items/7e71e007cf8d41a07a1a

let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME


" Define settings"{{{1

" public settings"{{{2

" Variables"{{{3
let s:profiles_dir_path = expand('<sfile>:h:h') . '/nvim/profiles/'
let s:profile_names = [
\   'basic_set',
\   'map',
\   'color',
\   'encoding',
\   'binary_mode',
\   'coding_style',
\   'vim-ref',
\]
"}}}3

" Functions to source public profiles"{{{3
function! s:source_profile(name)
    let l:path = printf('%s%s.vim', s:profiles_dir_path, a:name)
    if filereadable(l:path)
        execute printf('source %s', l:path)
    endif
endfunction

function! s:source_profiles(names)
    for l:name in a:names
        call s:source_profile(l:name)
    endfor
endfunction

function! s:call_source_profiles(args)
    call s:source_profiles(split(a:args, '[, :]'))
endfunction
"}}}3

" Command to source public profiles"{{{3
command! -nargs=+ ResourceProfile call s:call_source_profiles(<q-args>)
"}}}3
"}}}2

" local settings"{{{2

" Variables"{{{3
let s:profiles_local_dir_path = g:config_home . '/nvim/local'
"}}}3

" for sourcing profiles under the local directory"{{{3
function! s:source_local_profile(name)
    let l:path = expand(printf('%s%s.nvim', s:profiles_local_dir_path, a:name))
    if filereadable(l:path)
        execute printf('source %s', l:path)
    endif
endfunction

function! s:source_local_profiles(names)
    for l:name in a:names
        call s:source_local_profile(l:name)
    endfor
endfunction

function! s:call_source_local_profiles(args)
    call s:source_local_profiles(split(a:args, '[, :]'))
endfunction
"}}}3

" Command to source local profiles"{{{3
command! -nargs=+ ResourceLocalProfile call s:call_source_local_profiles(<q-args>)
"}}}3
"}}}2

"}}}1


" Define and initialize VimrcAutoCmd augroup {{{1
augroup VimrcAutoCmd
    autocmd!
augroup END
"}}}1

" Leader key needs to be set before any other mappings are defined.
" So define it here before loading dein settings where I have defined lots of
" "hook_add" defining mappings with <Leader>.
let mapleader = ","
" Swap "\" and ",".
noremap \ ,

" Source settings {{{1
""""" " First, source bundles{{{2
""""" "    I decided to stick with NeoBundle as some my working environments are
""""" "    CentOS 7 where Python3 is not installed by default.
""""" call s:source_profile('bundles')
call s:source_profile('dein')
""""" "}}}2
" Then, source profiles defined above {{{2
call s:source_profiles(s:profile_names)
"}}}2
""""" " Last, source local settings{{{2
""""" let g:path_to_vimrc_profile = s:profiles_local_dir_path . '/vimrc_profile'
""""" if filereadable(expand(g:path_to_vimrc_profile))
"""""     execute printf('source %s', expand(g:path_to_vimrc_profile))
""""" endif
"}}}2
"}}}1

" vim: softtabstop=4 shiftwidth=4 expandtab foldmethod=marker
