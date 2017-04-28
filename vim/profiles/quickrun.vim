" Settings for QuickRun
"
" Notes
" * Default settings can be found in:
"     :let g:quickrun#default_config
" * Buffer local command line arguments would be helpful in many cases.
"     :let b:quickrun_config={'args': 'foo bar'}
"

" This script is almost a full copy of the following great item in github:
"   - [quickrun.vim の設定](https://gist.github.com/osyo-manga/5134267)


function! s:quickrun_config()
    return unite#sources#quickrun_config#quickrun_config_all()
endfunction


" quickrun-runner {{{

" vimscript_all {{{
let s:runner = {}
let s:runner.name = "vimscript_all"
let s:runner.kind = "runner"

let g:is_quickrun_vimscript_all_running = 0

function! s:runner.run(commands, input, session)
    let code = 0
    for cmd in a:commands
        let [result, code] = s:execute(cmd)
        call a:session.output(result)
        if code != 0
            break
        endif
    endfor
    return code
endfunction


" :QuickRun vim で呼び出しているので
" if !exists("quickrun_running")
if !get(g:, "quickrun_running", 0)
    function! s:execute(cmd)
        let result = ''
        let error = 0
        let temp = tempname()

        let save_vfile = &verbosefile
        let &verbosefile = temp

        let old_errmsg = v:errmsg
        let v:errmsg = ""

        try
            silent! execute a:cmd
        catch
            let error = 1
            silent echo v:throwpoint
            silent echo matchstr(v:exception, '^Vim\%((\w*)\)\?:\s*\zs.*')
        finally
            let error = !empty(v:errmsg)
            let v:errmsg = old_errmsg
            if &verbosefile ==# temp
                let &verbosefile = save_vfile
            endif
        endtry

        if filereadable(temp)
            let result .= join(readfile(temp, 'b'), "\n")
            let result =  substitute(result, "\n行", "行", "g")
            call delete(temp)
        endif

        return [result, error]
    endfunction
endif

call quickrun#module#register(s:runner, 1)
unlet s:runner

" }}}

" }}}


" quickrun-outputter {{{

" location-list {{{
let s:outputter = quickrun#outputter#buffered#new()
let s:outputter.name = "location_list"
let s:outputter.kind = "outputter"
let s:outputter.config = {
\   'errorformat': '',
\ }

function! s:outputter.init(session)
    call call(quickrun#outputter#buffered#new().init, [a:session], self)
    let self.config.errorformat = empty(self.config.errorformat) ? &g:errorformat : self.config.errorformat
endfunction

function! s:outputter.finish(session)
    try
        let errorformat = &g:errorformat
        if !empty(self.config.errorformat)
            let &g:errorformat = self.config.errorformat
        endif

        lgetexpr self._result
        lwindow
        for winnr in range(1, winnr('$'))
            if getwinvar(winnr, '&buftype') ==# 'quickfix'
                call setwinvar(winnr, 'quickfix_title', 'quickrun: ' .
                \    join(a:session.commands, ' && '))
                break
            endif
        endfor
    finally
        let &g:errorformat = errorformat
    endtry
endfunction

call quickrun#module#register(s:outputter, 1)
unlet s:outputter
" }}}


" quickfix {{{
let s:outputter = quickrun#outputter#buffered#new()
let s:outputter.name = "quickfix"
let s:outputter.kind = "outputter"
let s:outputter.config = {
\   'errorformat': '',
\   'open_cmd': 'cwindow',
\ }

let s:outputter.init_buffered = s:outputter.init

function! s:outputter.init(session)
    call self.init_buffered(a:session)

    let self.config.errorformat
\       = !empty(self.config.errorformat) ? self.config.errorformat
\       : !empty(&l:errorformat)          ? &l:errorformat
\       : &g:errorformat
endfunction


function! s:outputter.finish(session)
    try
        let errorformat = &g:errorformat
        let &g:errorformat = self.config.errorformat

        cgetexpr self._result
        silent execute self.config.open_cmd
        for winnr in range(1, winnr('$'))
            if getwinvar(winnr, '&buftype') ==# 'quickfix'
                call setwinvar(winnr, 'quickfix_title', 'quickrun: ' .
                \    join(a:session.commands, ' && '))
                break
            endif
        endfor
    finally
        let &g:errorformat = errorformat
    endtry
endfunction
call quickrun#module#register(s:outputter, 1)
unlet s:outputter
" }}}


" quickfix_vim_script {{{
let s:outputter = quickrun#outputter#buffered#new()
let s:outputter.name = "quickfix_vim_script"
let s:outputter.kind = "outputter"
let s:outputter.config = {
\   'open_cmd': 'cwindow',
\ }



function! s:vsqf_funcname(line)
    let funcname  = matchstr(a:line, 'function.*<SNR>\d*_\zs[A-z|_]*\ze')
    return empty(funcname) ? matchstr(a:line, 'function \zs.*\ze,') : funcname
endfunction


function! s:vsqf_lnum(filelines, line)
    let funcname = s:vsqf_funcname(a:line)
    let lnum = matchstr(a:line, '.*行\s*\zs\d*\ze')
    if empty(lnum)
        return -1
    else
        return (empty(funcname) ? 0 : match(a:filelines, 'function.*'.funcname.'\s*(') + 1) + lnum
    endif
endfunction

function! s:make_vim_script_qflist(filename, errors)
    let filelines = readfile(a:filename)
    let errors    = a:errors
    let bufnr     = bufnr(a:filename)
    return map(a:errors, '{
\       "bufnr" : bufnr,
\       "lnum" : s:vsqf_lnum(filelines, v:val),
\       "text" : v:val,
\}')
endfunction


function! s:outputter.finish(session)
    let messages = self._result

    let file = a:session.config.srcfile
    let qflist= s:make_vim_script_qflist(file, split(messages, "\n"))
    call setqflist(qflist, 'r')

    silent execute self.config.open_cmd
    for winnr in range(1, winnr('$'))
        if getwinvar(winnr, '&buftype') ==# 'quickfix'
            call setwinvar(winnr, 'quickfix_title', 'quickrun: ' .
            \    join(a:session.commands, ' && '))
            break
        endif
    endfor
endfunction
call quickrun#module#register(s:outputter, 1)
unlet s:outputter
" }}}


" replace-region {{{
let s:outputter = quickrun#outputter#buffered#new()
let s:outputter.name = "replace_region"
let s:outputter.kind = "outputter"
let s:outputter.config = {
\   'errorformat': '',
\       "first" : "0",
\       "last"  : "0",
\       "back_cursor" : "0"
\ }

let s:outputter.init_buffered = s:outputter.init

function! s:outputter.init(session)
    call self.init_buffered(a:session)
endfunction


function! s:pos(lnum, col, ...)
    let bufnr = get(a:, 1, 0)
    let off   = get(a:, 2, '.')
    return [bufnr, a:lnum, a:col, off]
endfunction


function! s:delete(first, last)
    let pos = getpos(".")
    call setpos('.', a:first)
    normal! v
    call setpos('.', a:last)
    normal! d
    call setpos(".", pos)
endfunction


function! s:outputter.finish(session)
    let data = self._result
    let region = a:session.config.region
    let first = self.config.first == 0 ? [0] + region.first : s:pos(self.config.first, 0)
    let last  = self.config.last  == 0 ? [0] + region.last  : s:pos(self.config.last,  0)

    if first[1] > last[1]
        return
    endif
    try
        let tmp = @*
        call s:delete(first, last)
        let data = substitute(data, "\r\n", "\n", "g")
        let @* = join(split(data, "\n"), "\n")
        if empty(@*)
            return
        endif
        normal! "*P

        if self.config.back_cursor
            call setpos('.', first)
        endif
    catch /.*/
        echoerr v:exception
    finally
        let @* = tmp
    endtry
endfunction


call quickrun#module#register(s:outputter, 1)
unlet s:outputter
" }}}




" append {{{
let s:outputter = {
\   "name" : "append",
\   "kind" : "outputter",
\   "config" : {
\       "line" : "0"
\   }
\}


function! s:outputter.init(session)
    let self.config.line = self.config.line == 0 ?  line('.') : self.config.line
endfunction

function! s:outputter.output(data, session)
    let data = substitute(a:data, "\r\n", "\n", "g")
    call append(self.config.line-1, split(data, "\n"))
endfunction

function! s:outputter.finish(session)
endfunction

call quickrun#module#register(s:outputter, 1)
unlet s:outputter
" }}}

" }}}


" quickrun-hook {{{


function! s:make_hook_points_module(base)
    return shabadou#make_hook_points_module(a:base)
endfunction
" }}}


" quickrun-hook-make_hook_command {{{
function! s:make_hook_command(base)
    return shabadou#make_hook_command(a:base)
endfunction
" }}}


" quickrun-hook-close_location-list {{{
let s:hook = s:make_hook_points_module({
\   "name" : "close_location_list",
\   "kind" : "hook",
\   "config" : {
\       "enable_exit" : 1
\   }
\})

function! s:hook.priority(point)
    return a:point == "exit"
\       ? -999
\       : 0
endfunction

function! s:hook.hook_apply(context)
    :lclose
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-hook-clear_quickfix {{{
let s:hook = s:make_hook_points_module({
\   "name" : "clear_quickfix",
\   "kind" : "hook",
\})

function! s:hook.hook_apply(context)
    if !empty(&g:errorformat)
        cgetexpr ""
    endif
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-hook-clear_quickfix {{{
let s:hook = s:make_hook_points_module({
\   "name" : "clear_location_list",
\   "kind" : "hook",
\})

function! s:hook.hook_apply(context)
    if !empty(&g:errorformat)
        lgetexpr ""
    endif
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-msvc_compiler {{{
" let s:hook = {
" \   "name" : "msvc_compiler",
" \   "kind" : "hook",
" \   "config" : {
" \       "enable" : 0,
" \       "target" : "",
" \   },
" \   "path" : "",
" \   "lib" : "",
" \   "libpath" : "",
" \   "include" : "",
" \}
" 
" function! s:hook.init(...)
"     if !self.config.enable
"         return
"     endif
"     let self.path = $PATH
"     let self.lib  = $LIB
"     let self.libpath = $LIBPATH
"     let self.include = $INCLUDE
" 
"     let $VSINSTALLDIR=self.config.target
"     let $VCINSTALLDIR=$VSINSTALLDIR."/VC"
" 
"     let $DevEnvDir=$VSINSTALLDIR."/Common7/IDE;"
"     "let $PATH=$FrameworkDir.$Framework35Version.";".$PATH
"     "let $PATH=$FrameworkDir.$FrameworkVersion.";".$PATH
"     let $PATH=$VSINSTALLDIR."Common7/Tools;".$PATH
"     let $PATH=$VCINSTALLDIR."/bin;".$PATH
"     let $PATH=$DevEnvDir.";".$PATH
" 
"     let $INCLUDE=$VCINSTALLDIR."/include;".$INCLUDE
"     let $LIB=$VCINSTALLDIR."/LIB;".$LIB
"     let $LIBPATH=$VCINSTALLDIR."/LIB;".$LIBPATH
" "   let $PATH="C:/Program\ Files/Microsoft\ Visual\ C++\ Compiler\ Nov\ 2012\ CTP/bin;".$PATH
" endfunction
" 
" function! s:hook.sweep(...)
"     if !self.config.enable
"         return
"     endif
"     let $PATH = self.path
"     let $LIB  = self.lib
"     let $LIBPATH = self.libpath
"     let $INCLUDE = self.include
" endfunction
" 
" call quickrun#module#register(s:hook, 1)
" unlet s:hook
" " }}}


" quickrun_running {{{
let s:hook = {
\   "name" : "quickrun_running",
\   "kind" : "hook",
\   "config" : {
\       "enable" : 0,
\       "variable_name" : "quickrun_running",
\   }
\}

function! s:hook.init(...)
    if self.config.enable
        execute "let g:".self.config.variable_name."=1"
    endif
endfunction

function! s:hook.on_exit(...)
    execute "unlet g:".self.config.variable_name
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-hook-banban {{{
let s:hook = {
\   "name" : "banban",
\   "kind" : "hook",
\   "index_counter" : 0,
\   "config" : {
\       "enable" : 0
\}
\}

function! s:hook.on_ready(session, context)
    let self.index_counter = -2
endfunction

function! s:hook.on_output(session, context)
    let self.index_counter += 1
    if self.index_counter < 0
        return
    endif
    let aa_list = [
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \   'ﾊﾞﾝ（⊃`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝ',
    \]
    echo aa_list[ self.index_counter / 5 % len(aa_list)  ]
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" make_quickrun_hook_anim {{{
function! s:make_quickrun_hook_anim(name, aa_list, wait)
    return shabadou#make_quickrun_hook_anim(a:name, a:aa_list, a:wait)
endfunction
" }}}


" niku_do_rei {{{
call quickrun#module#register(s:make_quickrun_hook_anim(
\   "niku_do_rei",
\   [
\       "└(◉⊖◉)┓三 ",
\       " 三┏(◉⊖◉)┘ｽﾞﾝ",
\       "└(◉⊖◉)┓三 ｽﾞﾝﾄﾞｺ",
\       " 三┏(◉⊖◉)┘ｽﾞﾝﾄﾞｺﾄﾞｺ",
\       "└(◉⊖◉)┓三 ｽﾞﾝﾄﾞｺﾄﾞｺﾄﾞｺ",
\       " 三┏(◉⊖◉)┘ｽﾞﾝﾄﾞｺﾄﾞｺﾄﾞｺﾄﾞｺ",
\       "└(◉⊖◉)┓三 ｽﾞﾝﾄﾞｺﾄﾞｺﾄﾞｺﾄﾞｺﾄﾞｺ",
\   ],
\   3,
\), 1)
" }}}


" kotoura_san {{{
call quickrun#module#register(s:make_quickrun_hook_anim(
\   "kotoura_san",
\   [
\       '(＞ワ＜三   )コシコシコシ', '( ＞ワ三＜  )コシコシコシ',
\       '(  ＞三ワ＜ )コシコシコシ', '(   三＞ワ＜)コシコシコシ',
\       '(  ＞三ワ＜ )コシコシコシ', '( ＞ワ三＜  )コシコシコシ'
\   ],
\   3,
\), 1)
" }}}


" quickrun-run_prevconfig {{{
let s:prev_config={}

let s:hook = {
\   "name" : "run_prevconfig",
\   "kind" : "hook",
\   "config" : {
\       "enable" : 0,
\   }
\}

function! s:hook.init(session)
    if self.config.enable
        if has_key(s:prev_config, "input") && empty(s:prev_config.input)
            call remove(s:prev_config, "input")
        endif
        call extend(a:session.config, s:prev_config, "force")
    endif
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook


let s:hook = {
\   "name" : "save_prevconfig",
\   "kind" : "hook",
\   "config" : {
\       "enable" : 1,
\   }
\}

function! s:hook.on_normalized(session, context)
    let s:prev_config = deepcopy(a:session.config)
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-add_cmdopt {{{
let s:hook = {
\   "name" : "add_cmdopt",
\   "kind" : "hook",
\   "config" : {
\       "enable" : 1,
\       "option" : "",
\       "priority" : 10,
\   }
\}

function! s:hook.on_normalized(session, context)
" function! s:hook.on_hook_loaded(session, context)
    if self.config.enable && has_key(a:session.config, "cmdopt")
        let a:session.config.cmdopt .= " ".self.config.option
    endif
endfunction

function! s:hook.priority(...)
    return self.config.priority
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-hook-add-include-option {{{
let s:hook = {
\   "name" : "add_include_option",
\   "kind" : "hook",
\   "config" : {
\       "enable" : 0,
\       "priority" : 0
\   },
\}

function! s:hook.on_normalized(session, context)
    let paths = filter(split(&path, ","), "len(v:val) && v:val !='.' && v:val !~ 'mingw'")
    if len(paths)
        let a:session.config.cmdopt .= " -I".join(paths, " -I")
    endif
endfunction

function! s:hook.priority(...)
    return self.config.priority
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-hook-dogrun {{{
function! s:resize(str, len)
    if  a:len <= 0
        return ""
    endif
    let result = a:str
    while (strwidth(result) > a:len)
        let list = split(result, '\zs')
        if len(list) == 1
            return ""
        endif
        let result = join(list[ :len(list)-2], "")
    endwhile
    return result
endfunction


let s:hook = {
\   "name" : "dogrun",
\   "kind" : "hook",
\   "counter" : 0,
\   "config" : {
\       "enable" : 0
\}
\}

function! s:hook.on_ready(session, context)
    let self.counter = -6
endfunction

function! s:hook.on_output(session, context)
    let self.counter += 1
    if self.counter < 0
        return
    endif

    let dog = ['-', '-', '-', '-', '=', '=', '≡', '(', '(', '(', 'Ｕ', '＾', 'ω', '＾', '）']
    let dog_str = "----==≡(((Ｕ＾ω＾）"
    let width = &columns-5
    let counter = self.counter/2
    let len = len(dog)

    if len > counter
        echo join(dog[ (counter * -1)-1 : ], "")
    else
        echo s:resize(repeat(" ", counter - len+1) . dog_str, width)
    endif
    if counter - len+1 > width
        let self.counter = -1
    endif
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-location_list_replate_tempname_to_bufnr {{{
let s:hook = shabadou#make_hook_points_module({
\   "name" : "location_list_replate_tempname_to_bufnr",
\   "kind" : "hook",
\   "config" : {
\       "priority" : 0,
\       "bufnr" : 0,
\       "winnr" : 0,
\   },
\})

function! s:hook.init(...)
    let self.config.bufnr = self.config.bufnr ? self.config.bufnr : bufnr("%")
    let self.config.bufnr = self.config.winnr ? self.config.winnr : winnr()
endfunction

function! s:replace_temp_to_bufnr(qf, tempname, bufnr)
    if bufname(a:qf.bufnr) ==# a:tempname
        let a:qf.bufnr = a:bufnr
    endif
    return a:qf
endfunction

function! s:hook.priority(...)
    return self.config.priority
endfunction

function! s:hook.on_exit(session, context)
    let winnr = self.config.winnr
    let tempname = a:session.config.srcfile
    if !has_key(a:session, "_temp_names")
\   || index(a:session._temp_names, tempname) == -1
        return
    endif
    let qflist = getloclist(winnr)
    let bufnr  = self.config.bufnr
    call map(qflist, "s:replace_temp_to_bufnr(v:val, tempname, bufnr)")
    call setloclist(winnr, qflist)
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-boost_link {{{
let s:hook = {
\   "name" : "boost_link",
\   "kind" : "hook",
\   "config" : {
\       "enable" : 0,
\       "lib_path" : "",
\       "libs" : [],
\       "version" : "",
\       "priority" : 0,
\       "suffix" : 0,
\   }
\}

function! s:hook.on_normalized(session, context)
    let a:session.config.exec .= 
\       "-L ". self.config.lib_path . " "
\     . join(map(copy(self.config.libs), "'-lboost_'.v:val.'-'.self.config.suffix.'-'.self.config.version"), " ")
endfunction

function! s:hook.priority(...)
    return self.config.priority
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}


" quickrun-redraw_exit{{{
let s:hook = {
\   "name" : "redraw_exit",
\   "kind" : "hook",
\   "config" : {
\       "enable" : 1,
\   }
\}

function! s:hook.on_exit(...)
    redraw
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}










" quickrun-config {{{

" g:quickrun_config の初期化
if exists("quickrun_running") || !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif

function! s:set_quickrun_config(name, base, config)
    let base = type(a:base) == type("") ? g:quickrun_config[a:base] : a:base
    let result = deepcopy(base)
    call extend(result, a:config, "force")
    let g:quickrun_config[a:name] = deepcopy(result)
endfunction

" デフォルト {{{
let s:config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright 12sp",
\       "outputter" : "multi:buffer:quickfix",
\       "outputter/buffer/running_mark" : "ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾞﾝ",
\       "outputter/quickfix/open_cmd" : "",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60,
\       "runner/vimproc/sleep" : 10,
\       "hook/inu/enable" : 1,
\       "hook/sweep/enable" : 0,
\       "hook/extend_config/enable" : 1,
\       "hook/extend_config/force" : 1,
\       "hook/close_buffer/enable_failure" : 1,
\       "hook/close_buffer/enable_empty_data" : 1,
\       "hook/unite_quickfix/enable_failure" : 1,
\       "hook/unite_quickfix/priority_exit" : 0,
\       "hook/unite_quickfix/unite_options" : "-no-quit -direction=botright -winheight=12 -max-multi-lines=32 -wrap",
\       "hook/close_unite_quickfix/enable_module_loaded" : 1,
\       "hook/echo/enable" : 1,
\       "hook/echo/enable_output_exit" : 1,
\       "hook/echo/priority_exit" : 10000,
\       "hook/echo/output_success" : "（＾ω＾U 三 U＾ω＾）",
\       "hook/echo/output_failure" : "(∪´;ﾟ;ω;ﾟ)･;'.､･;'.･;';ﾌﾞﾌｫ",
\       "hook/clear_quickfix/enable_hook_loaded" : 1,
\       "hook/clear_location_list/enable_hook_loaded" : 1,
\       "hook/hier_update/enable_exit" : 1,
\       "hook/quickfix_stateus_enable/enable_exit" : 1,
\       "hook/quickfix_replate_tempname_to_bufnr/enable_exit" : 1,
\       "hook/quickfix_replate_tempname_to_bufnr/priority_exit" : -10,
\       "hook/unite_quickfix/no_focus" : 1,
\       "hook/quickrunex/enable" : 1,
\       "hook/back_tabpage/enable_exit" : 1,
\       "hook/back_tabpage/priority_exit" : -2000,
\       "hook/back_window/enable_exit" : 1,
\       "hook/back_window/priority_exit" : -1000,
\   },
\}

call extend(g:quickrun_config, s:config)
unlet s:config
" }}}


" 実行 {{{
let s:config = {
\   "run/vimproc" : {
\       "exec": "%s:p:r %a",
\       "hook/output_encode/encoding" : "utf-8",
\       "runner" : "vimproc",
\       "outputter" : "buffer",
\       "hook/unite_quickfix/enable" : 0,
\       "hook/failure_close_buffer/enable" : 0,
\       "hook/close_buffer/enable_empty_data" : 1,
\       "hook/close_buffer/enable_exit" : 0,
\       "hook/close_buffer/enable_failure" : 0,
\       "hook/extend_config/enable" : 0,
\   },
\}

call extend(g:quickrun_config, s:config)
unlet s:config
" }}}


" vim {{{
let s:config = {
\   "vim" : {
\       'command': ':source',
\       'exec': '%C %s',
\       'hook/eval/template': "echo %s",
\       'runner': 'vimscript_all',
\       "type" : "vim/homu"
\   },
\   "vim/_" : {
\   },
\   "vim/homu" : {
\       'command': ':source',
\       'exec': '%C %s',
\       'hook/eval/template': "echo %s",
\       "outputter" : "multi:buffer:quickfix_vim_script",
\       "outputter/open_cmd" : "",
\       "runner" : "vimscript_all",
\       "hook/quickrun_running/enable" : 1,
\   },
\   "vim/test2" : {
\       'command': ':source',
\       'exec': ["%C %s", "call owl#run('%s')"],
\       "outputter" : "buffer",
\       "runner" : "vimscript",
\   },
\   "vim/test" : {
\       'command': ':source',
\       'exec': ["%C %s", "call owl#run('%s')"],
\       "outputter" : "quickfix",
\       "outputter/open_cmd" : "",
\       "runner" : "vimscript_all",
\       "hook/quickrun_running/enable" : 1,
\       "hook/unite_quickfix/enable_exist_data" : 1,
\   },
\   "vim/async" : {
\       'command': 'vim',
\       'exec': '%C -N -u NONE -i NONE -V1 -e -s --cmd "set fileformat=unix" --cmd "source %s" --cmd qall!',
\       "runner" : "vimproc",
\       "hook/output_encode/encoding" : "sjis",
\   },
\}

" \     'exec': '%C -N -u NONE -i NONE -V1 -e -s --cmd "set fileformat=unix" --cmd "source %s" --cmd qall!',

command! -nargs=* OwlRun call owl#run(<q-args>)

call extend(g:quickrun_config, s:config)
unlet s:config
" }}}


" cpp {{{

let s:gcc_option = " -Wall"
let s:clang_option = s:gcc_option

let s:gcc_errorformat = "%f:%l:%c:\ %t%*[^:]:%m,%m\ %f:%l:"

let s:config = {
\
\   "cpp" : {
\       "type" : "cpp/g++",
\       "hook/extend_config/enable" : 1,
\       "hook/close_buffer/enable_exit" : 1,
\   },
\
\   "cpp/_" : {
\       "hook/quickrunex/enable" : 1,
\       "hook/add_include_option/enable" : 1,
\       "hook/unite_quickfix/enable_exist_data" : 1,
\       "hook/close_buffer/enable_exit" : 1,
\       "hook/boost_link/version" : "1_52",
\       "hook/boost_link/suffix" : "mgw47-mt",
\       "hook/boost_link/lib_path" : $BOOST_LATEST_ROOT."/stage/lib",
\       "hook/boost_link/libs" : ["context"],
\       "subtype" : "run/vimproc",
\   },
\
\   "cpp/g++03" : {
\       "command"   : "g++",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option,
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++" : {
\       "command"   : "g++",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option." -std=gnu++0x",
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.6.3" : {
\       "command"   : $GCCS_ROOT."/gcc4_6_3/_bin/g++",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option." -std=gnu++0x",
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.6.3-03" : {
\       "command"   : $GCCS_ROOT."/gcc4_6_3/_bin/g++",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option,
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.7.2" : {
\       "command"   : $GCCS_ROOT."/gcc4_7_2/_bin/g++",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option." -std=gnu++0x",
\       "hook/boost_link/enable" : 0,
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.8" : {
\       "command"   : $GCCS_ROOT."/gcc4_8/_bin/g++.exe",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option." -std=gnu++0x",
\       "hook/boost_link/enable" : 0,
\       "outputter/quickfix/errorformat" : s:gcc_errorformat.',%mfrom\ %f:%l\,',
\       "outputter/location_list/errorformat" : s:gcc_errorformat,
\   },
\
\   "cpp/g++4.8-03" : {
\       "command"   : $GCCS_ROOT."/gcc4_8/_bin/g++.exe",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option,
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.8-O2" : {
\       "command"   : $GCCS_ROOT."/gcc4_8/_bin/g++.exe",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option." -O2 -std=gnu++0x",
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.8-O3" : {
\       "command"   : $GCCS_ROOT."/gcc4_8/_bin/g++.exe",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option." -O3 -std=gnu++0x",
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.8-OpenGL" : {
\       "command"   : $GCCS_ROOT."/gcc4_8/_bin/g++.exe",
\       "exec" : "%c %o %s -o %s:p:r -lglut32 -lglu32 -lopengl32 -lglew32 ",
\       "cmdopt"    : s:gcc_option." -std=gnu++0x",
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.8-pedantic" : {
\       "command"   : $GCCS_ROOT."/gcc4_8/_bin/g++.exe",
\       "exec" : "%c %o %s -o %s:p:r ",
\       "cmdopt"    : s:gcc_option." -std=gnu++0x -pedantic -pedantic-errors",
\       "outputter/quickfix/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\       "outputter/location_list/errorformat" : '%f:%l:%c:\ %t%*[^:]:%m,%f:%m',
\   },
\
\   "cpp/g++4.8-preprocessor" : {
\       "command"   : $GCCS_ROOT."/gcc4_8/_bin/g++.exe",
\       "exec" : "%c %o %s:p  ",
\       "cmdopt"    : s:gcc_option." -P -E -std=gnu++0x",
\       "outputter" : "buffer",
\       "buffer/filetype" : "cpp",
\       "hook/close_buffer/enable_empty_data" : 1,
\       "hook/close_buffer/enable_success" : 0,
\       "hook/close_buffer/enable_failure" : 0,
\       "hook/unite_quickfix/enable" : 0,
\       "hook/close_unite_quickfix/enable" : 0,
\   },
\
\   "cpp/syntax_check" : {
\       "command"   : $GCCS_ROOT."/gcc4_8/_bin/g++.exe",
\       "exec"      : "%c %o %s:p ",
\       "outputter" : "quickfix",
\       "cmdopt"    : "-fsyntax-only -std=gnu++0x -fconstexpr-depth=4096 -Wall ",
\       "runner"    : "vimproc",
\       "hook/unite_quickfix/enable" : 0,
\       "hook/close_buffer/enable_exit" : 0,
\       "hook/redraw_unite_quickfix/enable_exit" : 1,
\       "hook/u_nya_/enable" : 0,
\       "hook/back_buffer/enable" : 0,
\       "hook/close_unite_quickfix/enable" : 0,
\   },
\
\   "cpp/bjam" : {
\       "command"   : $BOOST_ROOT."/bjam",
\       "exec" : "%c %o",
\       "hook/output_encode/encoding" : "sjis",
\       "hook/add_include_option/enable" : 0,
\   },
\
\
\}
call extend(g:quickrun_config, s:config)
unlet s:config
" }}}


" python {{{
let s:config = {
\   "python" : {
\       "type" : "python/p3",
\       "hook/output_encode/encoding" : "utf8",
\   },
\   "python/p3" : {
\       "command"   : "python3",
\       "exec"      : "%c %o %s:p ",
\   },
\   "python/p2" : {
\       "command"   : "python2",
\       "exec"      : "%c %o %s:p ",
\   },
\   "python/syntax_check" : {
\       "command" : "pylint",
\       "exec"    : "%c %s:p",
\       "outputter" : "quickfix",
\       "quickfix/errorformat" : "%f: line %l\\,\ col %c\\, %m",
\       "vimproc/sleep"    : 0,
\       "hook/unite_quickfix/enable" : 0,
\       "hook/close_unite_quickfix/enable" : 0,
\       "hook/close_buffer/enable_exit" : 1,
\       "hook/u_nya_/enable" : 0,
\   },
\   "python/syntax_check2" : {
\       "command" : "pylint2",
\       "exec"    : "%c %s:p",
\       "outputter" : "quickfix",
\       "quickfix/errorformat" : "%f: line %l\\,\ col %c\\, %m",
\       "vimproc/sleep"    : 0,
\       "hook/unite_quickfix/enable" : 0,
\       "hook/close_unite_quickfix/enable" : 0,
\       "hook/close_buffer/enable_exit" : 1,
\       "hook/u_nya_/enable" : 0,
\   },
\}

call extend(g:quickrun_config, s:config)
unlet s:config
"}}}


" ruby {{{
let s:config = {
\   "ruby" : {
\       "cmdopt" : "-Ku",
\   },
\   "ruby/utf8" : {
\       "cmdopt" : "-Ku",
\       "type" : "ruby"
\   },
\   "ruby/syntax_check" : {
\       "command" : "ruby",
\       "exec"    : "%c %s:p %o",
\       "cmdopt"  : "-c",
\       "outputter" : "quickfix",
\       "vimproc/sleep"    : 0,
\       "hook/unite_quickfix/enable" : 0,
\       "hook/close_unite_quickfix/enable" : 0,
\       "hook/close_buffer/enable_exit" : 1,
\       "hook/u_nya_/enable" : 0,
\   },
\}

call extend(g:quickrun_config, s:config)
unlet s:config
"}}}


" JavaScript {{{
let s:config = {
\   "javascript" : {
\       "quickfix/errorformat" : '%A%f:%l,%Z%p%m'
\   },
\   "javascript/syntax_check" : {
\       "command" : "jshint",
\       "exec"    : "%c %s:p",
\       "outputter" : "quickfix",
\       "quickfix/errorformat" : "%f: line %l\\,\ col %c\\, %m",
\       "vimproc/sleep"    : 0,
\       "hook/unite_quickfix/enable" : 0,
\       "hook/close_unite_quickfix/enable" : 0,
\       "hook/close_buffer/enable_exit" : 1,
\       "hook/u_nya_/enable" : 0,
\   },
\}

call extend(g:quickrun_config, s:config)
unlet s:config
"}}}


" Shellscript {{{
let s:config = {
\   "sh" : {
\       "quickfix/errorformat" : '%A%f:%l,%Z%p%m'
\   },
\   "sh/syntax_check" : {
\       "command" : "shellcheck",
\       "exec"    : "%c %s:p",
\       "outputter" : "quickfix",
\       "quickfix/errorformat" : "%f: line %l\\,\ col %c\\, %m",
\       "vimproc/sleep"    : 0,
\       "hook/unite_quickfix/enable" : 0,
\       "hook/close_unite_quickfix/enable" : 0,
\       "hook/close_buffer/enable_exit" : 1,
\       "hook/u_nya_/enable" : 0,
\   },
\}

call extend(g:quickrun_config, s:config)
unlet s:config
"}}}


" マッピング {{{
" QuickRun

" 1つ前にコンパイルしたファイルでコンパイル
nnoremap <silent> <Leader><C-r> :QuickRun -hook/run_prevconfig/enable 1<CR>

function! GetNowQuickrunConfig()
    return extend(copy(get(g:quickrun_config, &filetype."/_", {})), get(unite#sources#quickrun_config#quickrun_config_all(), unite#sources#quickrun_config#config_type(), {}), "force")
endfunction

" 実行
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
" }}}


" }}}


command! -nargs=* -range=0 -complete=customlist,quickrun#complete
\   QuickRun
\   call quickrun#command(extend(quickrun#config(<q-args>), get(g:quickrun_config, &filetype."/_", {}), "keep"), <count>, <line1>, <line2>)

let g:unite_quickfix_is_multiline=0


