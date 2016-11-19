" Settings for howm

" For Linux
" qfixappにruntimepathを通す
set runtimepath+=~/.vim/qfixapp

"キーマップリーダー
let QFixHowm_Key = 'g'

" howm_dir is defined in a local vim file.
ResourceLocalProfile local_howm
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding = 'utf-8'
let howm_fileformat = 'unix'

" "cygwin grep を使用する
" let mygrepprg = 'grep'

" For Windows
" TBD
