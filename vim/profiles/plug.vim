" Vim-plug (junegunn/vim-plug)

if &compatible
    set nocompatible
endif

" Automatic installation -- the following must be done before plug#begin().
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
let s:plug_cache_dir = g:cache_home . '/vim-plug'
call plug#begin(s:plug_cache_dir)

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'kana/vim-submode'
Plug 'kana/vim-tabpagecd'
Plug 'kana/vim-altr'
Plug 'thinca/vim-ref'
Plug 'easymotion/vim-easymotion'
Plug 'w0rp/ale'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
Plug 'itchyny/lightline.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'KabbAmine/zeavim.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'Yggdroot/indentLine'
Plug 'tomtom/tcomment_vim'
Plug 'haya14busa/incsearch.vim'
Plug 'thinca/vim-quickrun'
Plug 'editorconfig/editorconfig-vim'

Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'freitass/todo.txt-vim', { 'for': 'todo' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'pearofducks/ansible-vim', { 'for': 'yaml.ansible' }

" PlugInstall and PlugUpdate will clone fzf in the dir and run the install script
Plug 'junegunn/fzf', { 'dir': g:data_home . '/fzf', 'do': './install --all' }
  " Both options are optional. You don't have to install fzf in ~/.fzf
  " and you don't have to run the install script if you use fzf only in Vim.

Plug 'osyo-manga/shabadou.vim'

Plug 'vim-scripts/gtags.vim'

Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

" Color scheme
Plug 'dracula/vim'
Plug 'romainl/Apprentice'
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'

call plug#end()
