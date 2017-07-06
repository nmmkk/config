" Color settings

" Note: convenient command for color settings
" １．今、何色でるのか試したい場合。
"
" :so $VIMRUNTIME/syntax/colortest.vim
"
" ２．今、どういうルールでハイライトされているのかを知りたい場合。
"
" :so $VIMRUNTIME/syntax/hitest.vim

set background=dark
" set background=light

" colorscheme desert
" colorscheme rdark
" colorscheme delek

" colorscheme gruvbox
" colorscheme Tomorrow-Night
" colorscheme Tomorrow-Night-Eighties
colorscheme dracula
" colorscheme default
" colorscheme solarized
" colorscheme molokai


""" set background=light
""" " 検索結果のハイライト色を変更する
""" verbose highlight Search term=reverse ctermfg=1 ctermbg=6

""" " 補完ポップアップメニューの色設定
""" highlight Pmenu ctermbg=grey
""" highlight PmenuSel ctermbg=lightcyan
""" highlight PmenuSbar ctermbg=2
""" highlight PmenuThumb ctermbg=3

""" " diff の色設定
""" if &diff
"""     set background=dark
"""     highlight DiffAdd ctermbg=lightgreen
"""     colorscheme stackoverflow
""" endif
