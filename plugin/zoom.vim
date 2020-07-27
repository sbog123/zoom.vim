if !has("gui_running")
  finish
endif

if &cp || exists("g:loaded_zoom")
    finish
endif
let g:loaded_zoom = 1

let s:save_cpo = &cpo
set cpo&vim

" keep default value
let s:current_font = &guifont

" command
command! -narg=0 ZoomIn    :call s:ZoomIn()
command! -narg=0 ZoomOut   :call s:ZoomOut()
command! -narg=0 ZoomReset :call s:ZoomReset()

" map
" TODO: Remap to Ctrl-=/- (might not be possible)
" nmap + :ZoomIn<CR>
" nmap - :ZoomOut<CR>
nmap <leader>= :ZoomIn<CR>
nmap <leader>- :ZoomOut<CR>
nmap <leader>0 :ZoomReset<CR>

" guifont size + 1
function! s:ZoomIn()
  if has("gui_gtk2") || has("gui_gtk3")
    let l:fsize = substitute(&guifont, '^\w* \(\d*\)$', '\1', '')
    let l:fsize += 1
    let l:guifont = substitute(&guifont, ' \(\d*\)$', ' ' . l:fsize, '')
    let &guifont = l:guifont
  elseif has("gui_win32")
    let l:fsize = substitute(&guifont, '^.*:h\([^:]*\).*$', '\1', '')
    let l:fsize += 1
    let l:guifont = substitute(&guifont, ':h\([^:]*\)', ':h' . l:fsize, '')
    let &guifont = l:guifont
  endif
endfunction

" guifont size - 1
function! s:ZoomOut()
  if has("gui_gtk2") || has("gui_gtk3")
    let l:fsize = substitute(&guifont, '^\w* \(\d*\)$', '\1', '')
    let l:fsize -= 1
    let l:guifont = substitute(&guifont, ' \(\d*\)$', ' ' . l:fsize, '')
    let &guifont = l:guifont
  elseif has("gui_win32")
    let l:fsize = substitute(&guifont, '^.*:h\([^:]*\).*$', '\1', '')
    let l:fsize -= 1
    let l:guifont = substitute(&guifont, ':h\([^:]*\)', ':h' . l:fsize, '')
    let &guifont = l:guifont
  endif
endfunction

" reset guifont size
function! s:ZoomReset()
  let &guifont = s:current_font
endfunction

let &cpo = s:save_cpo
finish

