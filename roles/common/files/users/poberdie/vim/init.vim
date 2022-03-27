"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General Settings --------------------------------------------------------- {{{

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set scrolloff=8
set sidescrolloff=30
set backup
set backupdir=~/.local/share/nvim/backup/
set relativenumber
set number
set hidden
set undofile
set nospell
set ignorecase
set smartcase
set conceallevel=2
set wrap
set noswapfile
set cursorcolumn
set cursorline
set colorcolumn=80
set autochdir
set autoread

" }}}

" Key Mappings ------------------------------------------------------------- {{{

" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader = "\<SPACE>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<CR>
nmap <leader>vr :source ~/.config/nvim/init.vim<CR>

" Map <Esc> to jj
inoremap jj <Esc>

" List current buffers
nnoremap <leader>b :Buffers<CR>

" Easier navigation in tabs
nnoremap <S-L> :tabnext<CR>
nnoremap <S-H> :tabprevious<CR>

" Easier splitting
nnoremap <leader>hh :split<CR>
nnoremap <leader>vv :vsplit<CR>

" Easier navigation in splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Create new tab with Ctrl-t
nnoremap <C-t> :tabnew<CR>

" Open file in default viewer
nmap <leader>x :!xdg-open %<CR><CR>

" Map omnicomplete to Ctrl-k
inoremap <C-k> <C-x><C-o>

" Fold opening/closing
inoremap <F8> <C-O>zo[z
nnoremap <F8> zo[z
inoremap <F9> <C-O>zo]z
nnoremap <F9> zo]z
inoremap <F10> <C-O>za
nnoremap <F10> za

" }}}

" PLUGINS ------------------------------------------------------------------ {{{

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/vimwiki.vim
source ~/.config/nvim/plugins/surround.vim
source ~/.config/nvim/plugins/gruvbox.vim
source ~/.config/nvim/plugins/ripgrep.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/floaterm.vim
" source ~/.config/nvim/plugins/snippets.vim
source ~/.config/nvim/plugins/beancount.vim

call plug#end()
doautocmd User PlugLoaded

" }}}

" AUTO-COMMANDS ------------------------------------------------------------ {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

augroup General
    " The following by the way removes all autocmds that are *within* this
    " Group when sourcing the config
    autocmd!
    autocmd BufWritePre *.* :call TrimWhitespace()
    autocmd BufWinLeave,BufWrite *.* mkview
    autocmd BufWinEnter *.* silent! loadview
    autocmd BufNewFile,BufRead */ansible-config/* if &ft == '' | set filetype=dosini | endif
augroup end

augroup git
    autocmd!

    " Start git commits in append mode and wrap lines at 72 characters
    autocmd Filetype gitcommit setlocal spell textwidth=72 | startinsert!
augroup end

let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        " When yanking in WSL on Windows, copy the yanked text to the clipboard
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" }}}

" Scripting ------------------------------------------------------------ {{{

fun! TrimWhitespace()
    if match(expand('%'), ".*\.md") == -1
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endif
endfun

" # Function to permanently delete views created by 'mkview'
function! MyDeleteView()
    let path = fnamemodify(bufname('%'),':p')
    " vim's odd =~ escaping for /
    let path = substitute(path, '=', '==', 'g')
    if empty($HOME)
    else
        let path = substitute(path, '^'.$HOME, '\~', '')
    endif
    let path = substitute(path, '/', '=+', 'g') . '='
    " view directory
    let path = &viewdir.'/'.path
    call delete(path)
    echo "Deleted: ".path
endfunction

" }}}
