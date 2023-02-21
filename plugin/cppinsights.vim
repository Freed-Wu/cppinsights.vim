if exists('g:loaded_cppinsights') || &cpoptions
  finish
endif

let s:save_cpoptions = &cpoptions
set cpoptions&vim

""
" Configure if load @plugin(name).
call g:cppinsights#utils#plugin.Flag('g:loaded_cppinsights', 1)
""
" Configure if |:vertical| |:split|.
call g:cppinsights#utils#plugin.Flag('g:cppinsights_vertical', 1)
""
" Configure what command use. If not exists, will warn and exit.
call g:cppinsights#utils#plugin.Flag('g:cppinsights_cmd', 'insights')
""
" Configure what window name use for split window. See |%:r|.
call g:cppinsights#utils#plugin.Flag('g:cppinsights_window_name', '%:r-insights.cpp')

augroup cppinsights
  autocmd!
  autocmd FileType cpp call s:init()
augroup END

function! s:init() abort
  ""
  " Only when current filetype is `cpp`, this command will be defined.
  "
  " |<bang>| configure if |:diffsplit|.
  command! -bang Insights call cppinsights#main('<bang>')
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
