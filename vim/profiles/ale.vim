let g:ale_sign_column_always = 1

let g:ale_c_gcc_options = '-Wall -Wcast-qual -Wmissing-prototypes -Wpointer-arith -Wshadow -Wstrict-prototypes'
let g:ale_c_cppcheck_options = '--enable=style,performance,portability,information,missingInclude --std=c11'
let g:ale_cpp_gcc_options = '-std=c++11 -Wall -Wcast-qual -Wmissing-prototypes -Wpointer-arith -Wshadow -Wstrict-prototypes'
let g:ale_cpp_cppcheck_options = '--enable=style,performance,portability,information,missingInclude --std=c11'

" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%] %(code): %%s [%severity%]'

" Key map
nnoremap [ALE] <nop>
nmap <Space>a [ALE]

nmap <silent> [ALE]k <Plug>(ale_previous_wrap)
nmap <silent> [ALE]j <Plug>(ale_next_wrap)
