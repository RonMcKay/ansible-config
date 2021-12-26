Plug 'gruvbox-community/gruvbox'

augroup GruvboxGroup
    autocmd!
    autocmd User PlugLoaded ++nested colorscheme gruvbox
    autocmd User PlugLoaded ++nested set background=dark
augroup end

