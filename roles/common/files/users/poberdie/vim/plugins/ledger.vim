Plug 'ledger/vim-ledger'

augroup filetype_ledger
    autocmd!
    autocmd BufNewFile,BufRead *.ledger,*.prices set filetype=ledger foldmethod=syntax
    autocmd FileType ledger nnoremap <buffer> { :call PreviousTransaction()<CR>
    autocmd FileType ledger nnoremap <buffer> } :call NextTransaction()<CR>
    autocmd FileType ledger nnoremap <buffer> <leader><S-A> :LedgerAlignBuffer<CR>
    autocmd FileType ledger nnoremap <buffer> <leader>aa :LedgerAlign<CR>
    autocmd FileType ledger vnoremap <buffer> <leader>aa :LedgerAlign<CR>
augroup END

function NextTransaction()
    execute "normal /^\\d\<CR>"
    nohl
endfunction

function PreviousTransaction()
    execute "normal ?^\\d\<CR>"
    nohl
endfunction

let g:ledger_decimal_sep=','
