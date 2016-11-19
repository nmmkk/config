" Settings for QuickRun

" Notes
" * Default settings can be found in:
"     :let g:quickrun#default_config
" * Buffer local command line arguments would be helpful in many cases.
"     :let b:quickrun_config={'args': 'foo bar'}
"

let g:quickrun_config = get(g:, 'quickrun_config', {} )

"     \ 'outputter' : 'quickfix',

"     \ 'outputter' : 'buffer',
"     \ 'outputter/buffer/split' : ':botright 10sp',
"     \ 'outputter/buffer/close_on_empty' : 1,

"     \ 'hook/simple_anim/enable' : 1,

"     \ 'hook/shabadoubi_touch_henshin/enable' : 1,
"     \ 'hook/shabadoubi_touch_henshin/wait' : 20,

"     \ 'hook/close_unite_quickfix/enable_hook_loaded' : 1,
"     \ 'hook/unite_quickfix/enable_failure' : 1,
"     \ 'hook/close_quickfix/enable_exit' : 1,
"     \ 'hook/close_buffer/enable_failure' : 1,
"     \ 'hook/close_buffer/enable_empty_data' : 1,
"     \ 'outputter' : 'multi:buffer:quickfix',
"     \ 'outputter/buffer/close_on_empty' : 1,
"     \ 'hook/shabadoubi_touch_henshin/enable' : 1,
"     \ 'hook/shabadoubi_touch_henshin/wait' : 5,
"     \ 'outputter/buffer/split' : ':botright 10sp',
"     \ 'runner' : 'vimproc',
"     \ 'runner/vimproc/updatetime' : 60,

let g:quickrun_config._ = {
    \ 'hook/close_unite_quickfix/enable_hook_loaded' : 1,
    \ 'hook/unite_quickfix/enable_failure' : 1,
    \ 'hook/close_quickfix/enable_exit' : 1,
    \ 'hook/close_buffer/enable_failure' : 1,
    \ 'hook/close_buffer/enable_empty_data' : 1,
    \ 'outputter' : 'multi:buffer:quickfix',
    \ 'hook/shabadoubi_touch_henshin/enable' : 1,
    \ 'hook/shabadoubi_touch_henshin/wait' : 5,
    \ 'outputter/buffer/split' : ':botright 10sp',
    \ 'runner' : 'vimproc',
    \ 'runner/vimproc/updatetime' : 60,
    \ }

" let g:quickrun_config.cpp = {
"     \ 'command' : 'g++',
"     \ 'cmdopt' : '-std=c++11 -Wall -Wextra',
"     \ }

let g:quickrun_config.cpp = {
    \ 'type' : 'cpp/g++',
    \ }
