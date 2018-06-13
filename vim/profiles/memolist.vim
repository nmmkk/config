nnoremap <Leader>mn  :MemoNew<CR>
nnoremap <Leader>ml  :MemoList<CR>
nnoremap <Leader>mg  :MemoGrep<CR>

let g:memolist_path = "~/Documents/memo"

" suffix type (default markdown)
let g:memolist_memo_suffix = "md"

" use denite (default 0)
let g:memolist_denite = 0

" use arbitrary denite source (default is 'file_rec')
"""let g:memolist_denite_source = "anything"

" use arbitrary denite option (default is empty)
"""let g:memolist_denite_option = "anything"

" Custom template
let g:memolist_template_dir_path = g:memolist_path . "/template"

" use delimiter of array in yaml front matter (default is ' ')
let g:memolist_delimiter_yaml_array = ','

" use when get items from yaml front matter
" first line string pattern of yaml front matter (default "==========")
let g:memolist_delimiter_yaml_start = "---"

" last line string pattern of yaml front matter (default "- - -")
let g:memolist_delimiter_yaml_end  = "---"
