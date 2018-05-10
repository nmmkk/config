" Recommended settings in the GitHub page
" (https://github.com/scrooloose/syntastic)

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Since syntastic v 3.9, it does not read any configuraiton file by default
" for a securify reason.
" https://github.com/vim-syntastic/syntastic/issues/2170
let g:syntastic_c_config_file = ".syntastic_c_config"
let g:syntastic_cpp_config_file = ".syntastic_cpp_config"

"--------------------------------------------------------------------------------
" Key-mapping
nnoremap [Syntastic] <nop>
nmap <Space>s [Syntastic]

nnoremap <silent> [Syntastic]c :SyntasticCheck<CR>
nnoremap <silent> [Syntastic]t :SyntasticToggleMode<CR>

" Source local settings for Syntastic
ResourceLocalProfile local_syntastic
