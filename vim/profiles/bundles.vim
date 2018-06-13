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
NeoBundle 'Shougo/neosnippet.vim' " neo-snippet plugin contains neocomplcache snippets source
NeoBundle 'Shougo/neosnippet-snippets' " The standard snippets repository for neosnippet
NeoBundle 'tpope/vim-fugitive' " fugitive.vim: a Git wrapper so awesome, it should be illegal
NeoBundle 'kien/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder.
NeoBundle 'flazz/vim-colorschemes' " one colorscheme pack to rule them all!

NeoBundle 'vim-scripts/gtags.vim' " Integrates GNU GLOBAL source code tag system with VIM.
NeoBundle 'Shougo/unite.vim' " :dragon: Unite and create user interfaces
NeoBundle 'Shougo/neocomplcache.vim' " Ultimate auto-completion system for Vim.
" NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimshell.vim' " :shell: Powerful shell implemented by vim.
NeoBundle 'Shougo/vimproc.vim' " Interactive command execution in Vim.
NeoBundle 'mark'
NeoBundle 'cecutil' " 14    Some utilities used by several of my scripts (window positioning, mark handling)
NeoBundle 'vim-scripts/Align' " Help folks to align text, eqns, declarations, tables, etc
NeoBundle 'vim-scripts/vcscommand.vim' " CVS/SVN/SVK/git/hg/bzr integration plugin
NeoBundle 'vim-scripts/linuxsty.vim' " Vim plugin to respect the Linux kernel coding style
NeoBundle 'vim-scripts/taglist.vim' " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
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
NeoBundle 'mzlogin/vim-markdown-toc' " :package: A vim 7.4+ plugin to generate table of contents for Markdown files.
NeoBundle 'kannokanno/previm' " Realtime preview by Vim. (Markdown, reStructuredText, textile)
NeoBundle 'tyru/open-browser.vim' " Open URI with your favorite browser from your most favorite editor
NeoBundle 'xolox/vim-misc' " Miscellaneous auto-load Vim scripts
NeoBundle 'xolox/vim-colorscheme-switcher' " Makes it easy to quickly switch between color schemes in Vim
NeoBundle 'thinca/vim-quickrun' " Run commands quickly.
NeoBundle 'w0rp/ale' " Asynchronous Lint Engine
NeoBundle 'maximbaz/lightline-ale' " ALE indicator for the lightline vim plugin
NeoBundle 'osyo-manga/unite-quickfix' " ''
NeoBundle 'osyo-manga/shabadou.vim' " ''
NeoBundle 'moznion/shabadou.vim-animation' " A progress animation plug-in for shabadou.vim
NeoBundle 'itchyny/lightline.vim' " A light and configurable statusline/tabline for Vim
NeoBundle 'bronson/vim-trailing-whitespace' " Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
NeoBundle 'Yggdroot/indentLine' " A vim plugin to display the indention levels with thin vertical lines
NeoBundle 'vim-scripts/ag.vim' " Use ag, the_silver_searcher (better than ack, which is better than grep)
NeoBundle 'vimperator/vimperator.vim' " ''
NeoBundle 'freitass/todo.txt-vim' " Vim plugin for Todo.txt
NeoBundle 'majutsushi/tagbar' " Vim plugin that displays tags in a window, ordered by scope
NeoBundle 'szw/vim-tags' " Ctags generator for Vim
NeoBundle 'tpope/vim-surround' " surround.vim: quoting/parenthesizing made simple
NeoBundle 'tpope/vim-repeat' " repeat.vim: enable repeating supported plugin maps with .
NeoBundle 'dag/vim-fish' " Vim support for editing fish scripts
NeoBundle 'davidhalter/jedi-vim' " Using the jedi autocompletion library for VIM.
NeoBundle 'dracula/vim' " :scream: A dark theme for Vim
NeoBundle 'ujihisa/unite-colorscheme' " A unite.vim plugin
NeoBundle 'KabbAmine/zeavim.vim' " Zeal for Vim
NeoBundle 'cespare/vim-toml' " Vim syntax for TOML

NeoBundle 'tpope/vim-unimpaired' " unimpaired.vim: pairs of handy bracket mappings

NeoBundle 'LucHermitte/lh-vim-lib', {'name': 'lh-vim-lib'} " Library of Vim functions
NeoBundle 'LucHermitte/local_vimrc', {'depends': 'lh-vim-lib'} " Per project/tree configuration plugins
NeoBundle 'kana/vim-submode' " Vim plugin: Create your own submodes

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
