" Recommended settings in the GitHub page
" (https://github.com/scrooloose/syntastic)

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"--------------------------------------------------------------------------------
" Key-mapping
nnoremap [Syntastic] <nop>
nnoremap <Space>s [Syntastic]

nnoremap <silent> [Syntastic]c :SyntasticCheck<CR>
nnoremap <silent> [Syntastic]t :SyntasticToggleMode<CR>

" Source local settings for Syntastic
ResourceLocalProfile local_syntastic
