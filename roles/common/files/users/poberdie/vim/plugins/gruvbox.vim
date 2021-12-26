Plug 'gruvbox-community/gruvbox'

augroup GruvboxGroup
    autocmd!
    autocmd User PlugLoaded ++nested colorscheme gruvbox
    autocmd ColorScheme gruvbox set background=dark
augroup end

