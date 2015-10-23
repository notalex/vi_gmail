if exists('g:loaded_vi_gmail')
  finish
else
  let g:loaded_vi_gmail = 1
endif

let current_folder_path = expand('<sfile>:p:h')
let s:bin_path = current_folder_path . '/../../../bin/'
let s:drb_client = s:bin_path . 'drb_client '

function! s:Begin()
  echom system(s:drb_client . 'inbox')
endfunction

command! ViGmail call <SID>Begin()
