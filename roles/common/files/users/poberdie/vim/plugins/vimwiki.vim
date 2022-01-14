Plug 'RonMcKay/vimwiki', { 'branch' : 'improve-tag-links-generation' }

" Create a vimwiki table
nnoremap <leader>at :VimwikiTable

" 'move-column-left/right' (mcl/r) in a Vimwiki Table
nnoremap <leader>mcl :VimwikiTableMoveColumnLeft<CR>
nnoremap <leader>mcr :VimwikiTableMoveColumnRight<CR>

" Generate vimwiki tag links and reload saved view of the file
nnoremap <leader>tl :CustomVimwikiGenerateTagLinks<Space>

" Clear markdown links
nnoremap <leader>cl f]f(ci)

" Format selected text with double stars
vmap <leader>fb <S-s>*gv<S-s>*

" Horizontal seperator
nnoremap <leader>hl o<CR><Esc>10i-<Esc>o

function! VimwikiFoldLevelCustom(lnum)
  let pounds = strlen(matchstr(getline(a:lnum), '^#\+'))
  if (pounds)
    return '>' . pounds  " start a fold level
  endif
  if getline(a:lnum) =~? '^\s*$'
    if (strlen(matchstr(getline(a:lnum + 1), '^#\+')))
      return '-1' " don't fold last blank line before header
    endif
  endif
  return '=' " return previous fold level
endfunction

augroup vimwikigroup
	autocmd!
	" automatically update links on read diary
	autocmd BufRead,BufNewFile,BufWinEnter diary.md VimwikiDiaryGenerateLinks

    " When opening a new diary day, run the template script and paste it in
    autocmd BufNewFile ~/wiki_*/diary/*.md silent 0r
        \ !~/configs/vim/diary_template.py '%'

    " Start new diary day in append mode in the header
    autocmd BufNewFile ~/wiki_*/diary/*.md exec 'norm gg' | startinsert!

    " Enable folding for vimwiki (markdown) files
    autocmd FileType vimwiki setlocal foldmethod=expr |
        \ setlocal foldenable | setlocal foldexpr=VimwikiFoldLevelCustom(v:lnum)
augroup end

let wiki_1 = {
    \ 'path': '~/wiki_work',
    \ 'syntax': 'markdown',
    \ 'ext': '.md',
    \ 'auto_tags': 1,
    \ 'auto_toc': 1,
    \ 'template_path': '~/wiki_work/html_templates',
    \ 'template_default': 'default',
    \ 'path_html': '~/wiki_work/site_html/',
    \ 'custom_wiki2html': 'vimwiki_markdown',
    \ 'template_ext': '.tpl'}

let wiki_2 = {
    \ 'path': '~/wiki_private',
    \ 'syntax': 'markdown',
    \ 'ext': '.md',
    \ 'auto_tags': 1,
    \ 'auto_toc': 1,
    \ 'template_path': '~/wiki_private/html_templates',
    \ 'template_default': 'default',
    \ 'path_html': '~/wiki_private/site_html/',
    \ 'custom_wiki2html': 'vimwiki_markdown',
    \ 'template_ext': '.tpl'}

let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_global_ext = 0
let g:vimwiki_folding = 'custom'
set foldlevel=30

