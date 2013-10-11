" http://www.youtube.com/watch?v=NMMCtY0TmQ8
function! ExecuteSQL()
    let g:sqlquery = @q
    if g:sqlquery == ""
        echo "The register q doesn't have a query"
        return 0
    endif
    call writefile(split(g:sqlquery, "\n"), 'c:\temp\vim.sql')

    if exists("g:my_run_buffer")
        " go to buffer
        set swb = usetab
        exec ":rightbelow sbuf " . g:my_run_buffer
    else
        bo new
        set buftype = nofile
        let g:my_run_buffer = bufnr("%")
        let g:mydb = "tempdb"
        let g:mydbserver = "(localdb)\\Projects"
    endif
    let mycommand = '%!sqlcmd -S' . g:mydbserver . ' -d' . g:mydb . ' -i "c:\temp\vim.sql"'

    exec mycommand
endfunction

vnoremap <Leader>x "qy:call ExecuteSQL()<CR>

