Plug 'nathangrigg/vim-beancount'

augroup filetype_beancount
    autocmd!
    autocmd FileType beancount set foldmethod=syntax
    autocmd FileType beancount nnoremap <buffer> { :call PreviousTransaction()<CR>
    autocmd FileType beancount nnoremap <buffer> } :call NextTransaction()<CR>
    autocmd FileType beancount nnoremap <buffer> <leader>aa :AlignCommodity<CR>
    autocmd FileType beancount vnoremap <buffer> <leader>aa :AlignCommodity<CR>
    autocmd FileType beancount inoremap <buffer> . .<C-\><C-O>:AlignCommodity<CR>
augroup END

function NextTransaction()
    execute "normal /^\\d\<CR>"
    nohl
endfunction

function PreviousTransaction()
    execute "normal ?^\\d\<CR>"
    nohl
endfunction

let g:beancount_separator_col=70
let g:beancount_root="~/ledger/philipp.beancount"