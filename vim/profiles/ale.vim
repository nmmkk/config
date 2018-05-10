let g:ale_sign_column_always = 1

let g:ale_cpp_cppcheck_options = '--enable=all'
let g:ale_cpp_gcc_options = '-std=c++11 -Wall'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Key map
nnoremap [ALE] <nop>
nmap <Space>a [ALE]

nmap <silent> [ALE]k <Plug>(ale_previous_wrap)
nmap <silent> [ALE]j <Plug>(ale_next_wrap)
