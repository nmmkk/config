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
