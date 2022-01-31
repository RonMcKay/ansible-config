" Search with fzf starting from ledger root
nnoremap <buffer> <leader>f :Files ~/ledger<CR>

" Start ripgrep search from ledger root
nnoremap <buffer> <leader>r :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ''", 1, fzf#vim#with_preview({"dir": "~/ledger"}), 0)<CR>
