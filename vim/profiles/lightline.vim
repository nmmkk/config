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

