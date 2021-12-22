" Ansible managed

command -buffer -nargs=* -complete=custom,vimwiki#tags#complete_tags
    \ CustomVimwikiGenerateTagLinks call vimwiki#tags#generate_tags(1, <f-args>) | loadview

function! UpdateGeneratedTagLinks() abort
    let headers = vimwiki#base#collect_headers()
    let header_level = vimwiki#vars#get_global('tags_header_level')
    let tags_header_text = vimwiki#vars#get_global('tags_header')
    let generated_tags_existing = 0
    for header in headers
        if header[1] == header_level && header[2] ==# tags_header_text
            let generated_tags_existing = 1
            break
        endif
    endfor

    if generated_tags_existing
        call vimwiki#tags#generate_tags(0)
        loadview
    endif
endfunction

augroup vimwiki
    autocmd BufWritePre ~/wiki_*/*.md call UpdateGeneratedTagLinks()
augroup end
