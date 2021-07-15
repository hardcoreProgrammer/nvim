function! g:SplitSetupForCPP()
    let l:fileName = expand('%:h:t')
    if(expand('%:e') == 'cpp' && winnr('$') <= 2)
        execute 'vs input.in | vertical resize 40 | split output.in'
    else
        echo "PLESE OPEN CPP FILE"
    endif
endfunction

function! g:CompileAndRun()
    let l:fileName = expand('%:t:r')
    if(expand('%:e') == 'cpp')
        execute '!g++ '. l:fileName .'.cpp -o compiled/'. l:fileName .' 2>output.in && ./compiled/'. l:fileName .'<input.in>output.in'
    else
        echo "Sorry we can't compile the other file leaving cpp"
    endif
endfunction

