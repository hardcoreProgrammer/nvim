function! s:pythonSplitSetupForCPP()
python3 << EOF
import vim
bufferSize = len(vim.windows);
winPos = 0
while(winPos != bufferSize):
    winPos += 1;
    vim.command(str(winPos) + "wincmd w")
    vim.command("let l:fileName = expand('%:t')");
    if vim.eval("l:fileName") == 'input.in' or vim.eval("l:fileName") == 'output.in':
        vim.command("quit")
        winPos -= 1
        bufferSize -= 1
EOF
endfunction

function! g:SplitSetupForCPP()
    let l:fileName = expand('%:h:t')
    if(expand('%:e') == 'cpp' && winnr('$') <= 2)
        execute 'vs input.in | vertical resize 40 | split output.in'
    elseif(expand('%:e') == 'cpp' && (winnr('$') == 4 || winnr('$') == 3))
        call s:pythonSplitSetupForCPP()
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

