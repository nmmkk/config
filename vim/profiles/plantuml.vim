" Ref: http://zbz5.net/sequence-diagrams-vim-and-plantuml

" I made a script "plantuml" in ${HOME}/bin/ , and the script calls
" "java -jar ${HOME}/bin/jar/plantuml.jar $@" .
" Thus, my vimrc does not have to overwrite the variable
" g:plantuml_executable_script which already points "plantuml" .
"""""" let g:plantuml_executable_script='java -jar ~/bin/plantuml'

" Without <C-L>, my terminal does not show the document contents.
nnoremap <F5> :w<CR> :silent make<CR><C-L>
inoremap <F5> <ESC>:w<CR> :silent make<CR><C-L>
vnoremap <F5> :<C-U>:w<CR> :silent make<CR><C-L>
