""
" Only when current filetype is `cpp`, this command will be defined.
"
" |<bang>| configure if |:diffsplit|.
command! -bang Insights call cppinsights#main('<bang>')
