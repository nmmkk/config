"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here.
"   NOTE: How to search a new plugin: Use Unite as below.
"           :Unite neobundle/search
"         See ":help :NeoBundle-examples" for more details.
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive' " fugitive.vim: a Git wrapper so awesome, it should be illegal
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

NeoBundle 'gtags.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache.vim'
" NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc'
NeoBundle 'mark'
NeoBundle 'cecutil'
NeoBundle 'Align'
NeoBundle 'vcscommand.vim'
NeoBundle 'linuxsty.vim'
NeoBundle 'taglist.vim'
NeoBundle 'indentpython.vim' " 0.1   An alternative indentation script for python
NeoBundle 'harveyzh/google_python_style' " google python style indent file for vim
NeoBundle 'fuenor/qfixhowm' " This is a test version of QFixHowm.
NeoBundle 'cohama/agit.vim' " A powerful Git log viewer
NeoBundle 'kmnk/vim-unite-giti' " unite source for using git
NeoBundle 'scrooloose/nerdtree' " A tree explorer plugin for vim.
NeoBundle 'thinca/vim-ref' " Integrated reference viewer.
NeoBundle 'aklt/plantuml-syntax' " vim syntax file for plantuml
NeoBundle 'godlygeek/tabular' " Vim script for text filtering and alignment
NeoBundle 'plasticboy/vim-markdown' " Markdown Vim Mode
NeoBundle 'kannokanno/previm' " Realtime preview by Vim. (Markdown, reStructuredText, textile)
NeoBundle 'tyru/open-browser.vim' " Open URI with your favorite browser from your most favorite editor
NeoBundle 'xolox/vim-misc' " Miscellaneous auto-load Vim scripts
NeoBundle 'xolox/vim-colorscheme-switcher' " Makes it easy to quickly switch between color schemes in Vim
NeoBundle 'thinca/vim-quickrun' " Run commands quickly.
NeoBundle 'scrooloose/syntastic' " Syntax checking hacks for vim
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'moznion/shabadou.vim-animation' " A progress animation plug-in for shabadou.vim
NeoBundle 'itchyny/lightline.vim' " A light and configurable statusline/tabline for Vim
NeoBundle 'bronson/vim-trailing-whitespace' " Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
NeoBundle 'Yggdroot/indentLine' " A vim plugin to display the indention levels with thin vertical lines
NeoBundle 'vim-scripts/ag.vim' " Use ag, the_silver_searcher (better than ack, which is better than grep)

NeoBundle 'unimpaired.vim'

" You can specify revision/branch/tag.
" NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------
