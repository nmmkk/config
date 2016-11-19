" Copied from https://github.com/Shougo/neosnippet.vim
"
" Plugin key-mappings.
imap <C-k>      <Plug>(neosnippet_expand_or_jump)
smap <C-k>      <Plug>(neosnippet_expand_or_jump)
xmap <C-k>      <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>    neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB>    neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"

" For snippet_compete marker
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" The location of my snippets
let s:my_snippet = '~/rc/vim/snippet/'
let g:neosnippet#snippets_directory = s:my_snippet

