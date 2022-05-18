" Search with fzf starting from wiki root
" Note: This needs `vimwiki_auto_chdir` to be enabled
nnoremap <buffer> <leader>f :execute 'Files ' . getcwd()<CR>

" Start ripgrep search from wiki root
" Note: This needs `vimwiki_auto_chdir` to be enabled
nnoremap <buffer> <leader>r :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ''", 1, fzf#vim#with_preview({"dir": getcwd()}), 0)<CR>

