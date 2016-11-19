" My vimrc

" For Windows {{{1
if has('win32') || has('win64')
    set shellslash
endif
"}}}1

" Add local .vim directory to runtimepath {{{1
let s:local_dot_vim_dir_path = expand('<sfile>:h:h') . '/vim/dot.vim'
execute 'set runtimepath+=' . s:local_dot_vim_dir_path
"}}}1

" Initial settings"{{{1
" Set my mapleader (default '\')"{{{2
let mapleader = ','
noremap \ ,
"}}}2
"}}}1

" Define settings"{{{1

" public settings"{{{2

" Variables"{{{3
let s:profiles_dir_path = expand('<sfile>:h:h') . '/vim/profiles/'
let s:profile_names = [
\   'basic_set',
\   'neocomplcache',
\   'neosnippet',
\   'vimshell',
\   'map',
\   'abbreviate',
\   'howm',
\   'encoding',
\   'filetype',
\   'coding_style',
\   'plantuml',
\   'markdown',
\   'colorscheme-switcher',
\   'kernel-coding-style',
\   'gnuglobal',
\   'taglist',
\   'syntastic',
\   'quickrun',
\   'fugitive',
\   'align',
\   'ctrlp',
\   'color',
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
let s:profiles_local_dir_path = '~/.rcfiles/vim/'
"}}}3

" for sourcing profiles under the local directory"{{{3
function! s:source_local_profile(name)
    let l:path = expand(printf('%s%s.vim', s:profiles_local_dir_path, a:name))
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

" Source settings {{{1
" First, source bundles{{{2
"    I decided to stick with NeoBundle as some my working environments are
"    CentOS 7 where Python3 is not installed by default.
call s:source_profile('bundles')
"}}}2
" Then, source profiles defined above {{{2
call s:source_profiles(s:profile_names)
"}}}2
" Last, source local settings{{{2
let g:path_to_vimrc_profile = '~/.vimrc_profile'
if filereadable(expand(g:path_to_vimrc_profile))
    execute printf('source %s', expand(g:path_to_vimrc_profile))
endif
"}}}2
"}}}1

" vim: softtabstop=4 shiftwidth=4 expandtab foldmethod=marker
