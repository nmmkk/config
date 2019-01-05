" Vim-plug (junegunn/vim-plug)

if &compatible
    set nocompatible
endif


"==============================================================================
"
" Automatic installation -- the following must be done before plug#begin().
"
"==============================================================================
function! s:install_vim_plug_if_not()
    if has('nvim')
        let l:install_location = expand('$HOME/.local/share/nvim/site/autoload/plug.vim')
    else
        if has('win32') || has('win64')
            let l:install_location = expand('$HOME/vimfiles/autoload/plug.vim')
        else
            let l:install_location = expand('$HOME/.vim/autoload/plug.vim')
        endif
    endif

    if !filereadable(l:install_location)
        let l:vim_plug_github = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        execute printf('silent !curl -fLo %s --create-dirs %s', l:install_location, l:vim_plug_github)
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endfunction

call s:install_vim_plug_if_not()

"==============================================================================
"
" Functions for Post Processes to be given to 'do'.
"
"==============================================================================
" function! PP_YCM(info) "{{{1
"     " info is a dictionary with 3 fields
"     " - name:   name of the plugin
"     " - status: 'installed', 'updated', or 'unchanged'
"     " - force:  set on PlugInstall! or PlugUpdate!
"     if a:info.status == 'installed' || a:info.force
"         !./install.py --clang-completer
"     endif
" endfunction "}}}1

"==============================================================================
"
" List plugins to be installed
"
"==============================================================================
let s:plug_cache_dir = g:cache_home . '/vim-plug'
call plug#begin(s:plug_cache_dir)

Plug 'junegunn/fzf', { 'dir': g:data_home . '/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'kana/vim-submode', { 'do': function('PP_submode') }
Plug 'kana/vim-submode'
Plug 'kana/vim-tabpagecd'
Plug 'kana/vim-altr'
Plug 'cohama/lexima.vim'
Plug 'kana/vim-smartchr'
Plug 'thinca/vim-ref'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'KabbAmine/zeavim.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-dispatch'
Plug 'janko-m/vim-test'
Plug 'Yggdroot/indentLine'
Plug 'tomtom/tcomment_vim'
Plug 'haya14busa/incsearch.vim'
Plug 'editorconfig/editorconfig-vim'
"" "Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Multiple marks -- vim-mark depends on vim-ingo-library
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'

" Completion
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/deoplete-clangx'
Plug 'wellle/tmux-complete.vim', { 'for': 'tmux' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'zchee/deoplete-zsh', { 'for': 'zsh' }
Plug 'ponko2/deoplete-fish', { 'for': 'fish' }

" Linter
Plug 'w0rp/ale'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'Shougo/neosnippet'

" Coding
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/gtags.vim'

" Launguages
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'freitass/todo.txt-vim', { 'for': 'todo' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'pearofducks/ansible-vim', { 'for': 'yaml.ansible' }
Plug 'aliou/bats.vim'

" Quickrun
Plug 'thinca/vim-quickrun'
Plug 'osyo-manga/shabadou.vim'

" Preview
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'

" Text format
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'

" Per project/tree configuration (lh-vim-lib is the dependent)
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

" Filer
Plug 'scrooloose/nerdtree'

" Color scheme
Plug 'dracula/vim'
Plug 'romainl/Apprentice'
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'

call plug#end()



" Post-install settings for the plugins {{{1

" deoplete {{{2
let g:deoplete#enable_at_startup = 1
"}}}2

" vim-submode {{{2
call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#leave_with('undo/redo', 'n', '', '<Esc>')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')

call submode#enter_with('winresize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winresize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winresize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winresize', 'n', '', '<C-w>-', '<C-w>-')
call submode#leave_with('winresize', 'n', '', '<Esc>')
call submode#map('winresize', 'n', '', '>', '<C-w>>')
call submode#map('winresize', 'n', '', '<', '<C-w><')
call submode#map('winresize', 'n', '', '+', '<C-w>+')
call submode#map('winresize', 'n', '', '-', '<C-w>-')

call submode#enter_with('buf', 'n', '', '[MyKey]bj', ':bnext<CR>')
call submode#enter_with('buf', 'n', '', '[MyKey]bk', ':bprevious<CR>')
call submode#map('buf', 'n', '', 'j', ':bnext<CR>')
call submode#map('buf', 'n', '', 'k', ':bprevious<CR>')

call submode#enter_with('err', 'n', '', '[MyKey]cj', ':cnext<CR>')
call submode#enter_with('err', 'n', '', '[MyKey]ck', ':cprevious<CR>')
call submode#map('err', 'n', '', 'j', ':cnext<CR>')
call submode#map('err', 'n', '', 'k', ':cprevious<CR>')

call submode#enter_with('tab', 'n', '', '[MyKey]tj', 'gt')
call submode#enter_with('tab', 'n', '', '[MyKey]tk', 'gT')
call submode#map('tab', 'n', '', 'j', 'gt')
call submode#map('tab', 'n', '', 'k', 'gT')
"}}}2

" vim-altr {{{2
nmap <F2>   <Plug>(altr-forward)
nmap <S-F2> <Plug>(altr-back)

call altr#reset()
" Custom rules for ansible
call altr#define('tasks/%.yml',
\                'handlers/%.yml',
\                'vars/%.yml',
\                'defaults/%.yml',
\                'meta/%.yml',
\                'tests/%.yml')
" }}}2

" vim-ref {{{2
" There settings are basically from
" https://github.com/thinca/config/blob/master/dotfiles/dot.vim/vimrc , which
" is written by the author of vim-ref.

let s:plugin_info = expand('~/.local/share/vim/info')
let g:ref_cache_dir = s:plugin_info . '/ref'

let g:ref_open = 'vsplit'

let g:ref_source_webdict_sites = {
\   'alc': {
\       'url': 'http://eow.alc.co.jp/search?q=%s',
\       'keyword_encoding': 'utf-8',
\       'cache': 1
\   },
\   'wikipedia': {
\       'url': 'http://ja.wikipedia.org/wiki/%s',
\       'line': 19
\   },
\   'wiktionary': {
\       'url': 'http://ja.wiktionary.org/wiki/%s',
\       'keyword_encoding': 'utf-8',
\       'cache': 1,
\   },
\   'weblio' : {
\       'url' : 'http://ejje.weblio.jp/content/%s'
\   },
\ }

function! g:ref_source_webdict_sites.alc.filter(output)
    return substitute(a:output, '^.\{-}\ze検索文字列', '', '')
endfunction

function! g:ref_source_webdict_sites.wikipedia.filter(output)
    return join(split(a:output, "\n")[18 :], "\n")
endfunction

function! g:ref_source_webdict_sites.weblio.filter(output)
    let lines = split(a:output, "\n")
    call map(lines, 'substitute(v:val, "\\v(発音記号|音声を聞く|ダウンロード再生)", "", "g")')
    return join(lines[60 : ], "\n")
endfunction

let g:ref_source_webdict_sites.default = 'alc'
let g:ref_source_webdict_use_cache = 1

nnoremap [VimRef] <nop>
nmap <Space>r [VimRef]

nnoremap <silent> [VimRef]<C-k> :<C-u>call ref#jump('normal', 'webdict', {'noenter': 1})<CR>
vnoremap <silent> [VimRef]<C-k> :<C-u>call ref#jump('visual', 'webdict', {'noenter': 1})<CR>
nnoremap <silent> [VimRef]a     :<C-u>Ref webdict alc<Space>
nnoremap <silent> [VimRef]<C-h> :<C-u>Ref <C-r>=ref#detect()<CR><Space>

if !exists('g:ref_detect_filetype')
    let g:ref_detect_filetype = {}
endif
function! g:ref_detect_filetype._(ft)
    return &keywordprg ==# ':help' ? '' : 'man'
endfunction
"}}}2

" lightline {{{2
" (https://github.com/itchyny/lightline.vim)
let g:lightline = {}

let g:lightline.component_expand = {
    \ 'linter_checking': 'lightline#ale#checking',
    \ 'linter_warnings': 'lightline#ale#warnings',
    \ 'linter_errors': 'lightline#ale#errors',
    \ 'linter_ok': 'lightline#ale#ok',
    \ }

let g:lightline.component_type = {
    \ 'linter_chekcing': 'left',
    \ 'linter_warnings': 'warning',
    \ 'linter_errors': 'error',
    \ 'linter_ok': 'left',
    \ }

let g:lightline.active = {
    \ 'right': [
    \       [ 'lineinfo' ],
    \       [ 'percent' ],
    \       [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ],
    \       [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]
    \ ],
    \ 'left': [
    \   [ 'mode', 'paste' ],
    \   [ 'fugitive', 'readonly', 'filename', 'modified' ]
    \ ]
    \ }

let g:lightline.colorscheme = 'wombat'

" As I haven't installed patched fonts, my setting below is just to show git
" brnach addtionally.
let g:lightline.component = {
    \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
    \ }

let g:lightline.component_visible_condition = {
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \ }
"}}}2

" vim-mark {{{2
" Remove the default overriding of * and #:
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
" }}}2

" incsearch {{{2
" Replace default search commands
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)

" One that does not move the cursor
map g/ <Plug>(incsearch-stay)

" Turn on hlsearch only during searching
" :h g:incsearch#auto_nohlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
"}}}2

" ale "{{{2
let g:ale_sign_column_always = 1

let g:ale_c_gcc_options = '-Wall -Wcast-qual -Wmissing-prototypes -Wpointer-arith -Wshadow -Wstrict-prototypes'
let g:ale_c_cppcheck_options = '--enable=style,performance,portability,information,missingInclude --force --std=c11'
let g:ale_cpp_gcc_options = '-std=c++11 -Wall -Wcast-qual -Wmissing-prototypes -Wpointer-arith -Wshadow -Wstrict-prototypes'
let g:ale_cpp_cppcheck_options = '--enable=style,performance,portability,information,missingInclude --force --std=c++11'

" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%] %(code): %%s [%severity%]'

" Key map
nnoremap [ALE] <nop>
nmap <Space>a [ALE]

nmap <silent> [ALE]k <Plug>(ale_previous_wrap)
nmap <silent> [ALE]j <Plug>(ale_next_wrap)
"}}}2

" ultisnips "{{{2
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<S-C-j>"
let g:UltiSnipsJumpBackwardTrigger="<S-C-k>"

let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=["UltiSnips", "UltiSnips-local"]
set runtimepath+=$HOME/Documents/vim
"}}}2

" gtags "{{{2
" for GNU GLOBAL (gtags)
nnoremap [GnuGlobal] <nop>
nmap <Space>g [GnuGlobal]

""""        ,q     検索結果Windowを閉じる
"        [GnuGlobal]g     ソースコードの grep
"        [GnuGlobal]l     このファイルの関数一覧
"        [GnuGlobal]j     カーソル以下の定義元を探す
"        [GnuGlobal]k     カーソル以下の使用箇所を探す
"        [GnuGlobal]n     次の検索結果へジャンプする
"        [GnuGlobal]p     前の検索結果へジャンプする
" nnoremap <silent> [GnuGlobal]q     <C-w><C-w><C-w>q

" Launch grep mode
nnoremap <silent> [GnuGlobal]g     :Gtags -g

" Display list of fucntions in the file.
nnoremap <silent> [GnuGlobal]l     :Gtags -f %<CR>

" Jump to where the target is defined.
""" nnoremap <silent> [GnuGlobal]j     :Gtags <C-r><C-w><CR>
nnoremap <silent> [GnuGlobal]j     :GtagsCursor<CR>

" Jump to where the target is used.
nnoremap <silent> [GnuGlobal]k     :Gtags -r <C-r><C-w><CR>

" Jump to the next item in quickfix.
""" nnoremap <silent> [GnuGlobal]n     :cn<CR>
""" nnoremap <C-j>  :cn<CR>  " ==> I should use ']q' from unimpaired.

" Jump to the previous item in quickfix.
""" nnoremap <silent> [GnuGlobal]p     :cp<CR>
""" nnoremap <C-k>  :cp<CR>  " ==> I should use '[q' from unimpaired.
"}}}2

" nerdtree "{{{2
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let g:NERDTreeBookmarksFile=$HOME . '/.config/vim/nerdtree/NERDTreeBookmarks'
"}}}2

" vim-markdown "{{{2

" Set header folding level
let g:vim_markdown_folding_level = 6
" Enable TOC window auto-fit
let g:vim_markdown_toc_autofit = 1
" Syntax Concealing
let g:vim_markdown_conceal = 0
" LaTeX math
let g:vim_markdown_math = 1
" YAML Front Matter
let g:vim_markdown_frontmatter = 1
" TOML Front Matter
let g:vim_markdown_toml_frontmatter = 1
" Do not require .md extensions for Markdown links
let g:vim_markdown_no_extensions_in_markdown = 1
" Auto-write when following link
let g:vim_markdown_autowrite = 1

"}}}2
"}}}1 " Post-install settings for the plugins
