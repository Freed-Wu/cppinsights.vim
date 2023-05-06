""
" @section Introduction, intro
" @library
" <doc/@plugin(name).txt> is generated by <https://github.com/google/vimdoc>.
" See <README.md> for more information about installation and screenshots.

""
" Configure if |:vertical| |:split|.
call g:cppinsights#utils#plugin.Flag('g:cppinsights#vertical', 1)
""
" Configure what command use. If not exists, will warn and exit.
call g:cppinsights#utils#plugin.Flag('g:cppinsights#cmd', 'insights')
""
" Configure what window name use for split window. See |%:r|.
call g:cppinsights#utils#plugin.Flag('g:cppinsights#window_name', '%:r-insights.cpp')
""
" Configure C++ standard cppinsights use.
call g:cppinsights#utils#plugin.Flag('g:cppinsights#cpp_standard', '-std=c++17')

""
" Main function for |:Insights|.
function! cppinsights#main(bang) abort
  if has('win32')
    let l:null = 'null'
  else
    let l:null = '/dev/null'
  endif
  let l:cmd = g:cppinsights#cmd . ' ' . expand('%') . ' -- ' . g:cppinsights#cpp_standard . ' 2>' . l:null
  try
    let l:text = trim(system(l:cmd))
  catch /^Vim\%((\a\+)\)\=:E677:/
    echohl WarningMsg
    echomsg l:cmd 'cannot be executed!'
    echohl None
    return
  endtry
  if a:bang == '!'
    let l:diff = 'diff'
  else
    let l:diff = ''
  endif
  if g:cppinsights#vertical == 1
    let l:vertical = 'vertical '
  else
    let l:vertical = ''
  endif
  let l:cmd = l:vertical . l:diff . 'split ' . g:cppinsights#window_name
  execute l:cmd
  %delete
  1put=l:text
  1delete
  setlocal buftype=nofile
endfunction
