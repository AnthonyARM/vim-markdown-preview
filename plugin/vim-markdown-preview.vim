"============================================================
"                    Vim Markdown Preview
"   git@github.com:JamshedVesuna/vim-markdown-preview.git
"============================================================

function! Vim_Markdown_Preview()
  exe "write"
  let curr_file = expand('%:p')
  let out_file = expand('%:p:h') . "/markdown-preview.html"
  call system('grip --export ' . curr_file . ' '.out_file )
  "call system('pandoc ' . curr_file . ' -o markdown-preview.html -V links-as-notes --highlight-style pygments -s')
  let chrome_wid = system("xdotool search --name '". curr_file . " - Grip - Google Chrome'")
  if !chrome_wid
    sleep 300m
    call system('see -g '.out_file)
  else
    let curr_wid = system('xdotool getwindowfocus')
    call system('xdotool windowmap ' . chrome_wid)
    call system('xdotool windowactivate ' . chrome_wid)
    sleep 300m
    call system("xdotool key 'ctrl+shift+r'")
    sleep 300m
    call system('xdotool windowactivate ' . curr_wid)
  endif
  sleep 700m
  call system('rm /tmp/vim-markdown-preview.html')
endfunction

autocmd Filetype markdown,md map <buffer> <C-p> :call Vim_Markdown_Preview()<CR>
"autocmd BufWritePost *.markdown,*.md :call Vim_Markdown_Preview()
