
function! funcs#ShiftAndKeepVisualSelection(cmd, mode)
  set nosmartindent
  if mode() =~ '[Vv]'
    return a:cmd . ":set smartindent\<CR>gv"
  else
    return a:cmd . ":set smartindent\<CR>"
  endif
endfunction

"Only apply to help files...
function! funcs#HelpInNewTab ()
  if &buftype == 'help'
    "Convert the help window to a tab...
    execute "normal \<C-W>T"
  endif
endfunction

"Function to show whether you are in paste mode or not
function! funcs#HasPaste()
  if &paste
    return 'PASTE MODE  '
  else
    return ''
  endif
endfunction

function! funcs#HighlightWordUnderCursor()
  hi MatchWord NONE
  let disabled_ft = ["qf", "fugitive", "nerdtree", "gundo", "diff", "fzf", "floaterm"]
  if &diff || &buftype == "terminal" || index(disabled_ft, &filetype) >= 0
    return
  endif
  if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
    hi MatchWord cterm=undercurl gui=undercurl guibg=#3b404a
    exec 'match' 'MatchWord' '/\V\<'.expand('<cword>').'\>/'
  else
    match none
  endif
endfunction

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! funcs#Yank(text) abort
  let escape = system('yank', a:text)
  " if v:shell_error
  "   echoerr escape
  " else
  "   call writefile([escape], '/dev/tty', 'b')
  " endif
endfunction

" automatically run yank(1) whenever yanking in Vim
" (this snippet was contributed by Larry Sanderson)
function! funcs#CopyYank() abort
  call funcs#Yank(join(v:event.regcontents, "\n"))
endfunction

function! funcs#Ag(...) abort
  return system(join(['ag'] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

function! funcs#Files(...) abort
  let save_efm = &efm
  let &errorformat='%f'
  let command = expandcmd(join(a:000, ' '))
  cgetexpr system(command)
  call setqflist([], 'a', {'title' : command})
  let &efm = save_efm
endfunction

function! funcs#BuffersAndOldFiles() abort
  let l:buffiles = map(getbufinfo({'buflisted': 1}), 'v:val.name')
  let l:files = map(copy(v:oldfiles), 'fnamemodify(v:val, ":p")')
  " remove duplicates from oldfiles
  let l:files = filter(copy(l:files), 'index(l:files, v:val, v:key+1) ==-1')
  " remove oldfiles load in buffers
  let l:files = filter(copy(l:files), 'index(l:buffiles, v:val) == -1')
  " remove non-existing files
  let l:files = filter(copy(l:files), 'filereadable(v:val)')
  let l:files = map(copy(l:files), 'fnamemodify(v:val, ":p")')
  let l:buffers = map(getbufinfo({'buflisted': 1}), '{"bufnr": v:val.bufnr}')
  let l:files = map(copy(l:files), '{"filename": v:val}')
  " put the entries in the quicklist
  call setqflist(extend(l:buffers, l:files))
  " set the title
  call setqflist([], 'a', {'title' : 'buffers+oldfiles'})
  copen
endfunction


fun! funcs#SMRemoveBoundaries(txt) abort
  let l:text = a:txt
  let l:text = escape(substitute(l:text, '"', '', 'g'), '|')
  let l:text = escape(substitute(l:text, '\\<', '', 'g'), '|')
  let l:text = escape(substitute(l:text, '\\>', '', 'g'), '|')
  return l:text
endfun

function! funcs#SearchProject() abort
  if v:hlsearch == 1
    return funcs#SMRemoveBoundaries(@/)
  else
    return ' '
  endif
endfun

