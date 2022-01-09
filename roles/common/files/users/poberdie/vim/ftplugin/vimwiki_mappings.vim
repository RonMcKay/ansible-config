" Search with fzf starting from wiki root
nnoremap <buffer> <leader>f :execute 'Files ' . vimwiki#vars#get_wikilocal('path')<CR>

" Start ripgrep search from wiki root
nnoremap <buffer> <leader>r :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ''", 1, fzf#vim#with_preview({"dir": vimwiki#vars#get_wikilocal("path")}), 0)<CR>

