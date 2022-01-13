
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

call s:denite_my_settings()


" Define mappings
call denite#custom#map('insert', '<c-g>', '<denite:leave_mode>', 'noremap')
call denite#custom#map('normal', '<down>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal','<up>','<denite:move_to_previous_line>','noremap')
call denite#custom#map('insert','<down>','<denite:move_to_next_line>','noremap')
call denite#custom#map('insert','<up>','<denite:move_to_previous_line>','noremap')
call denite#custom#map('insert','<c-a>','<denite:move_caret_to_head>','noremap')
call denite#custom#map('insert','<home>','<denite:move_to_top>','noremap')
call denite#custom#map('insert','<end>','<denite:move_to_bottom>','noremap')
call denite#custom#map('insert','<c-home>','<denite:move_to_first_line>','noremap')
call denite#custom#map('insert','<c-end>','<denite:move_to_last_line>','noremap')

