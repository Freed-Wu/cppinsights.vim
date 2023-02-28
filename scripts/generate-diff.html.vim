#!/usr/bin/env -S vi -u
set runtimepath+=.
filetype on
edit examples/main.cpp
Insights!
augroup init
  autocmd!
  autocmd VimEnter * call s:init()
augroup END

function! s:init() abort
  TOhtml
  " delete the last blank line
  $delete
  saveas! diff.html
  qall
endfunction
