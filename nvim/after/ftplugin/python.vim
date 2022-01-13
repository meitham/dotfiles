
setlocal foldmethod=manual
setlocal expandtab shiftwidth=4 softtabstop=4 autoindent smartindent textwidth=119

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

setlocal omnifunc=pythoncomplete#Complete
" setlocal omnifunc=deoplete#mappings#manual_complete()

let g:pep8_map='<leader>8'

" setlocal formatprg=autopep8\ -aa\ --max-line-length\ 120\ --indent-size\ 0\ -
setlocal formatprg=~/.config/bin/pyformat.py\ -

let g:neomake_python_enabled_makers = ['flake8']

nnoremap <buffer> ,db oimport pdb; pdb.set_trace()<esc>

call neomake#configure#automake('nrwi', 500)
" set highlight duration time to 1000 ms, i.e., 1 second
let g:highlightedyank_highlight_duration = 1000

""python with virtualenv support
"py3 << EOF
"from isort import SortImports
"import vim
"new_contents = SortImports(file_contents=vim.current.buffer).output
"vim.current.buffer[:] = new_contents
"EOF
""
" if has("python")
" py << EOF
" import os.path
" import sys
" import vim
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   sys.path.insert(0, project_base_dir)
"   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
" EOF
" endif
